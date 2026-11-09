Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794232124;
	b=g7Ahi3ocjPw5TAX/PCJVa7+hgJxDhsPELLs1DszmBp6hrHt5+16NibDGQfZnakg4Gk8K
	 PYWSxGJ7ZQ1FkVPmrrM5jEcc5DrpULIg0adepYVm31ndyv7NQGXFAls2JWlrmtY2n6OKN
	 efyuCeG0PKR2xap0WCL5T0B8AJheb5VcHjp6R/pbzaeZLDwbBdYK+2U9G5hCKCRtKLsdp
	 vRdCD/qfAiqGl01F7AAicLhUQbEaLFUfSCIwB05oXb9711/4Er/DK1bnNIdcGlil09QNV
	 RcjbrTUsjZPZ1DgQYnI7wYx6XVinea9uYbhS+3fcTOPTPn3xuBAY8v1LP7dFvEezbWg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794232124;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=nYjIdwe6nVNUiJwfrKE7/ebvVRpi8vNOI6DfZKYgfPE=;
	b=pXGk/ReZIyGsZzzFXdCYENHPW/arzQx+4+qxerScMMV0yjTNZHpu6So5q4/2+WhBT8Qo
	 rNu7xD0P/BpyRmGByUtqFaOOlqThtOGy/EAoMbSTWDWIoXUYUEgPO8Q09ncXkI15B6o3s
	 oY7XW4A/ZA1aL/Tb2Nbs3CVSYWv81usSrhABvrGk6GOos7+2z9oUQETY/r2/5KYE0D63s
	 selwwZNbHPnTcmpSPNSeqUz3HjRPTV0vMPCKeBBH1NJVMi53T5/ciCaf1GT1ZnhQ6e2Pl
	 GFCK4qA1fjyPUzOU5aXcZageE7467bqiqKAmMxbT5Sy/s/TcVdEZjZBjX9w98HefjAA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U+RRBDq1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9732F606A331;
	Mon,  9 Nov 2026 13:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U+RRBDq1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 424651F0089F;
	Mon,  9 Nov 2026 13:48:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794232124;
	bh=nYjIdwe6nVNUiJwfrKE7/ebvVRpi8vNOI6DfZKYgfPE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=U+RRBDq1BB7ys6OzHXrJyADjRINtHDgyfy1yrDb/B8T68gpn8MYKosyWrlZS531VX
	 02AjzpZ53fL9iO7lH9QkXNTfgl3fV9qqSVm5jHKoryO88788nQ360jXl8hxgh36had
	 H4v7RsQdzVWlykG0i51gK1vfiiI1VtYqd3of/dXFGwFOKXhoUMTGSnhjhr1S2FQkVE
	 Br1hYDWuGel7Wu/3sYqgKOi8X9IkhdmLH7vqFp/1NsOsOY/DnZ/5uQ1GCfXzAi3rmO
	 +lxnfVJqdudQ4nkvKZELpS113kqd4z6RFaPsdfkb/wPPHbkrE4oMJXEsbtRdJDONBm
	 ZH/+CP1yL8XdQ==
Subject:
 Re: [PATCH net-next 1/2] sysfs: facilitate creating an empty directory
From: netdev-bot+sashiko@kernel.org
To: hkallweit1@gmail.com
Cc: davem@davemloft.net, andrew+netdev@lunn.ch, edumazet@google.com,
 kuba@kernel.org, horms@kernel.org, gregkh@linuxfoundation.org,
 rafael@kernel.org, dakr@kernel.org, johan@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, driver-core@lists.linux.dev
Date: Mon, 09 Nov 2026 13:48:42 +0000
Message-ID: <179423212274.994134.387871053470036049@kernel.org>
In-Reply-To: <340683d8-83f5-415b-b54c-b2916817f860@gmail.com>
References: <340683d8-83f5-415b-b54c-b2916817f860@gmail.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] This patch silently reverses the semantics that commit
  a91845b9a872 ("sysfs: Skip empty folders creation") set up on purpose…
- [Low] The kernel-doc for struct attribute_group in
  include/linux/sysfs.h (lines 101-103) still says "@bin_attrs: ...…
- [Low] The comment and debug message on the rewritten check in
  internal_create_group() (fs/sysfs/group.c:144-147) are misleading.

--

sysfs: facilitate creating an empty directory

This patch changes the early return in internal_create_group() so that it
only skips groups with no name and no attrs or bin_attrs. A named group with
both arrays NULL now gets an empty sysfs directory. Callers no longer need an
attribute list that holds only the sentinel entry.

> diff --git a/fs/sysfs/group.c b/fs/sysfs/group.c
> index 4e1e4f18a1669..031cb6f36b5b0 100644
> --- a/fs/sysfs/group.c
> +++ b/fs/sysfs/group.c
> @@ -141,9 +141,10 @@ static int internal_create_group(struct kobject *kobj, int update,
>  	if (unlikely(update && !kobj->sd))
>  		return -EINVAL;
>  
> -	if (!grp->attrs && !grp->bin_attrs) {
> -		pr_debug("sysfs: (bin_)attrs not set by subsystem for group: %s/%s, skipping\n",
> -			 kobj->name, grp->name ?: "");
> +	/* If name is set w/o attributes, create an empty directory */
> +	if (!grp->name && !grp->attrs && !grp->bin_attrs) {

[Severity: Medium]
This reverses behaviour that commit a91845b9a872 ("sysfs: Skip empty
folders creation") added on purpose. Was that intended?

That commit's message covers a group "with a name and without .[bin_]attrs
members". It says sysfs should "just skip the attribute group creation". It
also calls an empty sysfs folder "disturbing".

After this change, a named group with attrs and bin_attrs both NULL always
gets a directory. That applies to sysfs_create_group(), sysfs_create_groups()
and device_add_group(). It also applies to sysfs_update_group() when the
directory doesn't exist yet.

__first_visible() returns 0 when both arrays are NULL. So mode becomes
S_IRWXU | S_IRUGO | S_IXUGO and the code reaches:

    kn = kernfs_create_dir_ns(kobj->sd, grp->name, mode,
                              uid, gid, kobj, NULL);
    if (IS_ERR(kn)) {
        if (PTR_ERR(kn) == -EEXIST)
            sysfs_warn_dup(kobj->sd, grp->name);
        return PTR_ERR(kn);
    }

A name clash used to return 0 quietly. It now returns -EEXIST and calls
sysfs_warn_dup(), and internal_create_groups() then rolls back the whole
group list.

Some named groups are declared with NULL attrs and filled in at run time.
One example is x86_pmu_format_group in arch/x86/events/core.c:

    static struct attribute_group x86_pmu_format_group __ro_after_init = {
        .name = "format",
        .attrs = NULL,
    };

I couldn't find an in-tree user that registers such a group with the arrays
still NULL. The x86 pmu, s390 PAI, amdgpu, i915, arm-cci and
nvmem_populate_sysfs_cells() users all fill the arrays or bail out first.
Even so, the commit message describes this only as changing one check.

Could the commit message reference a91845b9a872 and explain why skipping
empty named groups is no longer wanted? Could it also say whether existing
named groups with runtime-filled attrs were checked?

[Severity: Low]
A named group with both arrays NULL is now a supported construct. However,
the kernel-doc for struct attribute_group in include/linux/sysfs.h still
says:

 * @attrs:	Pointer to NULL terminated list of attributes.
 * @bin_attrs:	Pointer to NULL terminated list of binary attributes.
 *		Either attrs or bin_attrs or both must be provided.

Should this be updated too? It could say that a named group with neither
array creates an empty directory, and only an unnamed one is skipped.

The follow-up change for wireless_group in net/core/net-sysfs.c depends on
this, and it doesn't touch the header either.

> +		pr_debug("sysfs: (bin_)attrs not set by subsystem for group: %s, skipping\n",
> +			 kobj->name);

[Severity: Low]
This isn't a bug, but the new comment describes what happens when the
condition is false. The block below it actually skips an unnamed group that
has no attributes.

The pr_debug() also prints kobj->name after "for group:". grp->name is
always NULL in this branch, so the printed value is the kobject name, not a
group name. The old "%s/%s" format kept the two separate.

There is also a typo in the commit message: "sentinal" should be "sentinel".

>  		return 0;
>  	}
>

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/0a0a7987-abb2-49c8-bc16-3938233ae9c5%40gmail.com
