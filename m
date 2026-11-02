Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793625222;
	b=BxC4dT/LWwzZTqj0zhUWUjR5QZD0O2h+FlNz9rqDppIu4E21yitYcSmcKjFA1rj0DT/A
	 B9zwNFyHBhn2ASRSP2ZqOBJpBFLdFo7TN5QyA2jiwNHryflroIyS2kgXKyj7MyakGGiEr
	 nPVnNjmEjNH6zsnp825q/NTavQ5wBHzFJt/MPSAoHzDwZsNvu4OlRV49EuJ0dfJh9UOz9
	 jgHYtUT3l6SVipxZCC/M5Kp2y593XIuUNejQ+yHa8Xb1oQ/inQrhlynn2YQhfhLIEs4XU
	 v9qai6UOKZ3lZqGj2IYE125lLJ59Jwcfj6HTsjjAV1pUCxpx7f/M33A3nWXmLs3FLHg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793625222;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=rC8xVMt0ftVC1MA0/AxMx0dm+YERO32RQqLOxWhbSdM=;
	b=s5HzoM9cnYLFBwy6BezqmXKkEF6i+XJeKjNwIYtN9HiF3qLDfs4UmVjPg9tyQGBqQ728
	 z4PCtXB3X+yvjBDY3RcszoVGhoh16mTnY4kt/CCpe1cX1jvhQNsGQyi2lvkjKqnFIAaAZ
	 jD0OjlbzcKKDoCdIoVEOlmQtHWLM1RQy5exn+nl4gTZzf3gs2BxTT2sIEzcrlJA+UnOFn
	 jiKm56fqz88IXTMGF0mt34OUMduNctoEC02QaEZFERqAnjCgRVtYUfQnzW9VA0y41M/bs
	 EMrU6MYh9RknF59NiR4i6aca3G9aF00969B6sd7AAaTREkSm3QxNpZ2NoZ7dcQWeiwg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=o9Bv0lrt;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.47
Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 470C9606A338
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 13:13:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 470C9606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=o9Bv0lrt
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-15ea896ddc8so5071086c88.0
        for <netdev@vger.kernel.org>; Mon, 02 Nov 2026 05:13:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793625220; cv=none;
        d=google.com; s=arc-20260327;
        b=EDOH7wT4mTN/aTPoypN7OZ0JY/91o44t7SAV5BNuMSP2QfB5fy6sqKq4VsdOXDYqNI
         8J1Ccfv4v6hF8ojtx7zL/K+ADO9EVZlwgwDIo3GXebw0I2OYleYo2tsfK9jlqwgS+8rA
         K2vlA3PLs7C7K2+g4d1qvTevi4lFqKnPxSYoOx2fBtjv+cLdix7h2V+IvVjoCoZ8S5zU
         pjAvdzIh+AtLo66k94THHEjt24L6k60+iBQtJCZIoVg+ORGsyjFq7tl8DEHf1tEAikRy
         IavgBoyEkel+2Ky5YaJPZpZqLJvPjgf53GYJYdMBNd9B9Xx4RwtsWyqbAP2iPAL/gF93
         9qxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rC8xVMt0ftVC1MA0/AxMx0dm+YERO32RQqLOxWhbSdM=;
        fh=hXBeJeGnt9KmB8bvi08ceqqi20QrcbJrT3e6wXBJ/vI=;
        b=MSF4ts4pE1iP3nuiatv0FBPYXwoWfYZEmgtYWj/rm6nxMfXlne58mCEoA+EwsUPmih
         k1ZjtI6PMGQ8MJLkYJXbGbXhOTvFcnA3sJu9RkE+GJSwVQvUF4lipL1CCxdXJd7A8BxU
         PC/TGJeJ58as/ZAKHMLrmtzyU5QmVQSfII4Osb0UJ4s41ANkyPCMpZhcWJztWQTvEBB/
         ago96lnYa++Eh2a2hjhop2O7eVXB9QbEA51/5aa8R9sZGweY6svmZ7bCCaUrdv8ssgeZ
         xoxOJYKG3zmVH8udc+Z4GyVm+wpaPEeIL+8M4yuMLESR6DU9DB8fvuhT2WVD+UfVEz/G
         N6nA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793625220; x=1794230020; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rC8xVMt0ftVC1MA0/AxMx0dm+YERO32RQqLOxWhbSdM=;
        b=o9Bv0lrtHh2cwTJJVMUH4k06fPh+ZUF1Xl51YCyt5LSal/HMFyjV6eP5ndcJg+7iVj
         WTAY3phbzSA8x/6rfLnLvb4bDnZ8Y4PG1EA0o2RPOfRyLwq6jcyjm/QiNRIf9j5AQQsJ
         l2LCkDlG//3sWy/odK1wwz5yKvgETNvSW47fduZrW/zlPZQm2Hr6OF9occ90dnwda9pH
         15peHnhylM0gwl1DeCkmpBva8CbqeJR2lmvPc9gUGtCRkIGAVwQC32c4UK+T3jOODMWv
         8UTKrgc631symoPetFblG9qRPrnzh0NbDQA57q01cYj3VhCGGF8OfpP+shjngzwAm22m
         UCwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793625220; x=1794230020;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rC8xVMt0ftVC1MA0/AxMx0dm+YERO32RQqLOxWhbSdM=;
        b=Tzy/BUGRa7ncTYNUbn7RxB+WHC1yKg611V8B+ylpd/2Cpp1HrLCvCpyaDjGNM5CzOC
         4x7azQTcXmaEyB6jzRDVrE/KQMW026gTDb5+Gx7l8dd3CinaXmEaWwORVoEPEgU4lo8K
         FcMQf6qpX/LtH2wyuByLaAo6iQzhid0QZghA/jUGhNImrjkPWsAYtnjUpKMOsDhr0up4
         E5lzxSxcvnnRG6Uagh5cJwg65L9coR7zYQk3mB/chh9n/g+wogb61r2IzTRll5yvjwYP
         bmcADwsBBzUfZjknmBJnOKTR3rDtofGUtU3WpUFU46C4T2WYtN9lcshtzh4lLvri+a3u
         mSFw==
X-Forwarded-Encrypted: i=1; AKwUvBy7bP8yrVQCFHuFQBPnDPnORN1JUQ2pKeILI9CwaBfwU9EAdauze4+v9a+CxevRbB//N6N6Qj0=@vger.kernel.org
X-Gm-Message-State: AFq9FYJv97MsGRwyUu6YUqds/g9AuhXUxUtiMd2rWFuyZdHbM9t91/Uy
	4ZRFLsdyuZllD1cf4jOF6J/0D7ZELGrOW8208qOPqUxJqB5RBvlmjLFKQaV9eBlX/mQhh3C1PJe
	/+KNPPuRRgaetCJXWAAPxTb/KRkFXtk0=
X-Gm-Gg: AYBFou0RtNLHxYfR6Lc0oD1PSi4ThUSppTAq9jMSUfQelEPUvDwB8tCciU7PtXBMu1A
	70+Lq74XAdIhlaoWDGko5HiTi6SRoBQMdJjbpEOH5ncs3kfdJ7JC2SgMbY2OinipWVVxdr1qve0
	IGp89pvafv48M5f4ZS1nABUM3+Z1cTRhiUkl9S9cmEhTPbRttf3hMirn8v43jjyIDvZjfwZS0xm
	Aeh5UHJq0Re2NGBJFGH3feD15r5qeihPn7KY3DIUJE5iO+WkDt8ei+k5CrJnyGS9YmfoC5L1oC+
	zaqViugFbSsEM5jaC85SV/G88yq5JTphpkPR2U9sHJIWtM5waWko+RjtmxiLr9GQ39JKBu+Y8X1
	oQKofCe5cn3PzpQipsyaAZ8CI2eTyZNa4/JmctWKpDHTtsI1Qi8E/BAI3hfDpqcBTB3sW
X-Received: by 2002:a05:701b:230e:b0:14a:8cff:fbb8 with SMTP id
 a92af1059eb24-1ac5bbb5053mr14722111c88.28.1793625220279; Mon, 02 Nov 2026
 05:13:40 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261102130540.252894-1-omosnacek@gmail.com>
In-Reply-To: <20261102130540.252894-1-omosnacek@gmail.com>
From: =?UTF-8?B?T25kcmVqIE1vc27DocSNZWs=?= <omosnacek@gmail.com>
Date: Mon, 2 Nov 2026 14:13:28 +0100
X-Gm-Features: AclHuK9Lk_3jmZnqSr1tjOillycrUr-WcgCLTZN6r2TRwhWtp1BoaHKbHJvYD28
Message-ID: <CAAUqJDvsDi5ceO3ri5cJP4WJbZeUdpJe9F4cv8OU4=wBzVeBAw@mail.gmail.com>
Subject: Re: [RFC PATCH] af_unix: introduce MSG_CMSG_SEALED
To: Eric Dumazet <edumazet@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Willem de Bruijn <willemb@google.com>, Jakub Kicinski <kuba@kernel.org>
Cc: Paul Moore <paul@paul-moore.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Simon Horman <horms@kernel.org>, 
	Jens Axboe <axboe@kernel.dk>, netdev@vger.kernel.org, selinux@vger.kernel.org, 
	linux-security-module@vger.kernel.org, io-uring@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2 Nov 2026 at 14:05, Ondrej Mosn=C3=A1=C4=8Dek <omosnacek@gmail.com=
> wrote:
>
> Currently, when a process receives a file through AF_UNIX's SCM_RIGHTS
> mechanism, the security_file_receive() LSM hook is calledto allow LSMs
> like SELinux to validate the receiver's access to the received file
> (similarly to a process inheriting file descriptors through execve(2)).
>
> However, there are cases (such as dbus daemon/dbus-broker) where the
> receiver doesn't intend to access the received file and merely wants to
> forward it to a third process. In this case the forwarding process would
> need to have the appropriate r/w access to the file in order to receive
> it, even though it will never actually acess it. That leads to the
> security policy having to grant the forwarder access to a potentially
> wide range of files (in case of dbus-broker basically all files), which
> is not ideal.
>
> This patch adds a new CMSG flag MSG_CMSG_SEALED that, when passed to
> recvmsg(2), wraps any received files into an opaque anonymous inode with
> the name "[envelope]", skipping the security_file_receive() LSM check.
> The returned "[envelope]" file descriptor can't be used in any
> meaningful way other than being passed forward via sendmsg(2) with the
> MSG_CMSG_SEALED flag. In that case the original file is unwrapped and
> sent via SCM_RIGHTS to the receiver. The receiver can then either
> receive the file as normal (subject to the LSM check) or again "sealed"
> in the "[envelope]" anon inode for further forwarding.
>
> Note that sending the "[envelope]" file is only allowed with the
> MSG_CMSG_SEALED flag set, to make the unsealing explicit and avoid
> unexpected behavior. Attempting to send it without this flag will fail
> with an error. This also avoids recursive nesting of "[envelope]" files,
> which would only make this feature harder to audit for possible issues.
>
> This patch also adds a simple read-only sockopt for UNIX sockets that
> allows userspace to determine if this feature is present (passing
> unknown CMSG flags unfortunately doesn't lead to an error currently).
> The minimal code to do so can look like this:
>
>     #ifndef SO_RIGHTS_SEALED_SUPPORTED
>     #define SO_RIGHTS_SEALED_SUPPORTED 88
>     #endif
>
>     #include <sys/socket.h>
>     #include <unistd.h>
>     #include <stdbool.h>
>
>     bool MSG_CMSG_SEALED_supported(void)
>     {
>         int sock, ret;
>         socklen_t optlen =3D 0;
>
>         sock =3D socket(AF_UNIX, SOCK_STREAM, 0);
>         if (sock < 0) {
>             /* handle error */
>             /* ... */
>         }
>
>         ret =3D getsockopt(sock, SOL_SOCKET, SO_RIGHTS_SEALED_SUPPORTED,
>                          NULL, &optlen);
>         close(sock);
>
>         return ret =3D=3D 0;
>     }
>
> Related: https://github.com/fedora-selinux/selinux-policy/issues/3286
> Related: https://github.com/fedora-selinux/selinux-policy/issues/3287
> Signed-off-by: Ondrej Mosn=C3=A1=C4=8Dek <omosnacek@gmail.com>
> ---
>  arch/alpha/include/uapi/asm/socket.h    |  2 +
>  arch/mips/include/uapi/asm/socket.h     |  2 +
>  arch/parisc/include/uapi/asm/socket.h   |  2 +
>  arch/sparc/include/uapi/asm/socket.h    |  2 +
>  include/linux/socket.h                  |  4 +-
>  include/net/scm.h                       |  2 +-
>  include/uapi/asm-generic/socket.h       |  2 +
>  io_uring/net.c                          |  2 +-
>  net/compat.c                            |  3 +-
>  net/core/scm.c                          | 81 +++++++++++++++++++++----
>  net/core/sock.c                         |  9 +++
>  net/socket.c                            |  2 +-
>  tools/include/uapi/asm-generic/socket.h |  2 +
>  13 files changed, 97 insertions(+), 18 deletions(-)

See also this RFC patch for selinux-testsuite
(https://github.com/SELinuxProject/selinux-testsuite) that I used to
test this patch:
https://lore.kernel.org/selinux/20261102130834.253605-1-omosnacek@gmail.com=
/
