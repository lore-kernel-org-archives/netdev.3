Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 397B64AD7C0
	for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 17:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789149272; cv=none; b=OViuIwChmJUvl6zpTyKGc7sRlzJAhkBcDK+0imbeqSe1Kk2WVvw4tGh6k6KA3IQpRm2kR+EaLJ0AB77EsrxSvRVjCY1+F6zaR8pJpRGzjvXDinbqqxV5714bCqm8bb/iPmTsfmb45EApG/jzP3JCEl4/pwhOggAdjGsdaBTA03Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789149272; c=relaxed/simple;
	bh=L4wtI723HCIDSARdKEZgFkF5oUZmZn6k/3N147HwuaQ=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QdFWmmvm27fvhJbuSR0GbsFz0cVM/c6wdusP17JNeaRXjUmwqScg9gAhY0aqBzC6FMV1DniuzwSLauXqfQL4vsQZlWbVOGcZI2ZOcRAp+Qgd2sLniVGgI9MU2sBM2mBmc/Rjo5j90ovq61Zjf6HJpQr0b3zdRjaPI+qeHDly3Ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oxQeBhRP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oxQeBhRP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1503A1F000FF;
	Fri, 11 Sep 2026 17:54:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789149268;
	bh=8KXoc4CQ4lfWWo+6gHxTYOqQVXyOnyX7bSY7BKHIY6M=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=oxQeBhRPSo/J4/EN8tKK3WTfPpZw7UNFDHUyH59NbU2tVguB+41yCMxsHIpuEGz+v
	 EqRHe9iZxOUtqF6ikOWyk54099JJeddW3r7fiUbYKWQrqIPoGow4TeIm/cU8ZPe9iG
	 gof0NdqyO0/xutTk4uKIiQ1RvXvt4nvkDgksvjS9DhWuQsXHmcHFl5BlhajOAWijPu
	 fQDfJvcrnvXr2TbOWGVGEsXRSB5w0W/NGuEciq0FvTeTpcMc+Pa+CQ4NbzvVDlTdM0
	 0x2R5WICV6Swcu1CduiaJHHTSHzPe27giXd/K3vNLYjGIb88g8UA/jco303vIdRWX3
	 YvuSskiIc7OKA==
Subject: Re: [PATCH net 1/1] net: preserve socketpair output on setup failure
From: netdev-bot+sashiko@kernel.org
To: sgrubb@redhat.com
Cc: netdev@vger.kernel.org, edumazet@google.com, kuniyu@google.com,
 pabeni@redhat.com, willemb@google.com, davem@davemloft.net, kuba@kernel.org,
 horms@kernel.org, shuah@kernel.org
Date: Fri, 11 Sep 2026 17:54:27 +0000
Message-ID: <178914926756.219967.8405366872721807955@kernel.org>
In-Reply-To: <JyK226D0S5CWGUpAC4MO4A@redhat.com>
References: <JyK226D0S5CWGUpAC4MO4A@redhat.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 1 · Low: 1

- [Medium] The new publication step in `__sys_socketpair()`
  (net/socket.c:1908-1916) still uses two independent `put_user()`…
- [Low] Undisclosed partial revert of commit 016a266bdfeda2
  ("socketpair(): allocate descriptors first") with no Fixes: tag and no…

--

net: preserve socketpair output on setup failure

This moves the two put_user() stores of the reserved descriptor numbers in
__sys_socketpair() from before socket creation to after both struct file
objects have been allocated, so a setup failure no longer leaves the
caller's array modified.  On a store failure both file references are
dropped before the reserved descriptor slots are released.

> diff --git a/net/socket.c b/net/socket.c
> index c05d86e63abf7..4cb8662869f09 100644
> --- a/net/socket.c
> +++ b/net/socket.c
> @@ -1851,10 +1851,7 @@ int __sys_socketpair(int family, int type, int protocol, int __user *usockvec)
>  	if (SOCK_NONBLOCK != O_NONBLOCK && (flags & SOCK_NONBLOCK))
>  		flags = (flags & ~SOCK_NONBLOCK) | O_NONBLOCK;
>  
> -	/*
> -	 * reserve descriptors and make sure we won't fail
> -	 * to return them to userland.
> -	 */
> +	/* Reserve both descriptors before creating the sockets. */

[Severity: Low]
Should this change carry a Fixes: tag?

git blame on net/socket.c shows the early put_user() pair and the comment
being removed here both came from commit 016a266bdfeda2 ("socketpair():
allocate descriptors first"), which deliberately published the descriptor
numbers before socket and file creation so the store to userland could not
fail late, and used that to simplify the failure exits.

Moving the stores back after sock_alloc_file() and re-adding the
two-object failure exit reverts that part of 016a266bdfeda2, and the
replacement comment drops the recorded invariant.  Could the changelog
mention 016a266bdfeda2 as the origin of the ordering being changed, so
that backporters can see what is being partially reverted?

>  	fd1 = get_unused_fd_flags(flags);
>  	if (unlikely(fd1 < 0))
>  		return fd1;
> @@ -1865,14 +1862,6 @@ int __sys_socketpair(int family, int type, int protocol, int __user *usockvec)
>  		return fd2;
>  	}
>  
> -	err = put_user(fd1, &usockvec[0]);
> -	if (err)
> -		goto out;
> -
> -	err = put_user(fd2, &usockvec[1]);
> -	if (err)
> -		goto out;
> -
>  	/*
>  	 * Obtain the first socket and check if the underlying protocol
>  	 * supports the socketpair call.

[ ... ]

> @@ -1916,6 +1905,16 @@ int __sys_socketpair(int family, int type, int protocol, int __user *usockvec)
>  		goto out;
>  	}
>  
> +	/* Publish the descriptors now that it shouldn't fail. */
> +	err = put_user(fd1, &usockvec[0]);
> +	if (!err)
> +		err = put_user(fd2, &usockvec[1]);
> +	if (err) {
> +		fput(newfile2);
> +		fput(newfile1);
> +		goto out;
> +	}
> +

[Severity: Medium]
Can usockvec[0] still be left modified on an error return here?

The publication is two independent stores, so the first can commit while
the second faults, for instance when usockvec is placed with the first int
in a writable page and the second int in a PROT_NONE page, or when an
mprotect()/userfaultfd race lands between the two accesses:

	err = put_user(fd1, &usockvec[0]);	/* commits */
	if (!err)
		err = put_user(fd2, &usockvec[1]);	/* -EFAULT */

The error path then falls through to:

out:
	put_unused_fd(fd2);
	put_unused_fd(fd1);
	return err;

so -EFAULT is returned to the caller while usockvec[0] still holds fd1,
and fd1 has been released and will be handed back out by the next
open()/socket()/accept() in the process.

The commit message says the current code "leaves a modified caller's array
despite returning an error, contrary to POSIX".  Is that state still
reachable after this change for the partial-store case?

Also, the new comment "Publish the descriptors now that it shouldn't fail."
is immediately followed by the handler for that publication failing.
Could the comment be reworded, or the two stores replaced with a single
copy_to_user() of a two-element array as do_pipe2() does in fs/pipe.c?

	if (unlikely(copy_to_user(fildes, fd, sizeof(fd)))) {
		fput(files[0]);
		fput(files[1]);
		put_unused_fd(fd[0]);
		put_unused_fd(fd[1]);
		error = -EFAULT;

Note that even the do_pipe2() form can copy the first int before faulting
on the second, so a straddling buffer leaves a residual window there too.

For the record, the two-store publication is not new in this patch, the
baseline had the same pattern; the question is only whether the changelog
claim of removing this behaviour holds.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/JyK226D0S5CWGUpAC4MO4A%40redhat.com
