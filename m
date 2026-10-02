Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2609C48F82F;
	Fri,  2 Oct 2026 10:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790937152; cv=none; b=M56yls5l+O4BLzf/wmSWS9rE9KVJvfbN9RoDekLMp0/kDHWoc/qwqA2TNOphCypTkOrwqvdDtEqFjqA7CyJig32NvyLukCiUJZnZKXUPm02RSrS/fevhzcVNAlvD/S072UMxFC0Fek5HviSNj+bIBr39DbKhglUIiSe6cjk6iyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790937152; c=relaxed/simple;
	bh=BxXMkYDIvDPAYaNWyObe4SqrEEuV/Qf4A+w5DOj6SQc=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RlzrEnzCVWdojrCj6rQjDDHC0o+HeHHVIKu/sL8ERoFUaR8TacfncC/iU0UrjzdOO3s24hWGhSiVOlRgAL6tNqYodCKgQNa35XvhbXlhf9xsr0jRcpdW1FPfK1jj27SPNDNIiSLNQYsgwJVFPTbI4sK2NNQJdDiEBhR6FQPEDLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EI8q6KNK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EI8q6KNK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 712491F00893;
	Fri,  2 Oct 2026 10:32:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790937151;
	bh=Rk64UMAyS92EITKojVbj4+IilNsXRlJ7LVq/Hmf0oC8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=EI8q6KNKoFbrRrcF+xRHQcMwOBG/rbyDF4aIwLj1ChVfe+36R498pnHv2F9g644FP
	 SW6/QQK9iZqlYSf256YtlV2eB/f9CUsOAv7S8qmXr9qernoUq6UGPL+bxwbr8rVE+y
	 Jl3l05NdHyWcPO3A72ceOXrXVd2s79A9QOXjBbYNJif2flx+TDm4BaAa8g+E4JvN/E
	 VLiZvGHkHChUEEeH3pUFU3fIdUKderLzM1jgIOo8G+lGFodpfQFyckqapaMLy0HiOJ
	 yMgS1KHJAYj8F9XGuCsd/jDVMaEkBlcYJVFWpoanp52QV58SONHeQZNCMCYVP6da/f
	 5OXThng5DTYVw==
Subject: Re: [PATCH 15/16 net-next v2] netlabel: cipso: introduce CONFIG_CIPSO
 to decouple IPv4 dependency
From: netdev-bot+sashiko@kernel.org
To: fmancera@suse.de
Cc: netdev@vger.kernel.org, horms@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, edumazet@kernel.org, davem@davemloft.net,
 edumazet@google.com, ebiggers@kernel.org, ardb@kernel.org, krzk@kernel.org,
 linux-kernel@vger.kernel.org
Date: Fri, 02 Oct 2026 10:32:30 +0000
Message-ID: <179093715004.434549.18075937713177476140@kernel.org>
In-Reply-To: <20260928193046.6698-16-fmancera@suse.de>
References: <20260928193046.6698-16-fmancera@suse.de>
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
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The NetLabel management PROTOCOLS dump
  (netlbl_mgmt_protocols() in net/netlabel/netlabel_mgmt.c) always lists…
- [Low] Concern about commit-message accuracy.

--

I found two possible issues in this patch and wrote them up as an inline reply for the list, shown below:

- **Medium:** with CONFIG_CIPSO=n, the NetLabel PROTOCOLS dump in netlbl_mgmt_protocols() still lists CIPSOv4 as available, but the protocol cannot be used.
- **Low:** the commit message says NetLabel and Smack can run on IPv6-only kernels. At this commit that setup cannot be selected yet, and the message doesn't say that Smack loses CIPSO labelling in it.

I checked both against the code at this commit: the protocol dump, the CIPSOv4 add path in netlbl_mgmt_add_common(), and Smack's smk_cipso_doi() and its callers.

netlabel: cipso: introduce CONFIG_CIPSO to decouple IPv4 dependency

This commit adds a CONFIG_CIPSO symbol, enabled when both NETLABEL and
IPV4 are set. The CIPSO objects, sysctls and kernel APIs are now gated on
it. The IPV4 dependency is dropped from the NetLabel Kconfig sourcing and
from Smack.

> By safely stubbing out the CIPSO netlabel_kapi functions to return
> -ENOSYS when disabled, this allows NetLabel and Smack to be successfully
> built and used on IPv6-only kernels.

[Severity: Low]
This isn't a bug, but at this commit CONFIG_IPV4 is still def_bool y in
net/ipv4/Kconfig, so a CIPSO=n configuration cannot be selected yet. The
IPv6-only case only becomes reachable with the follow-up patch "ipv4: make
CONFIG_IPV4 boolean". Should the commit message say that?

With CIPSO=n, Smack also runs without CIPSO labelling. The boot-time call
in init_smk_fs() fails without any message, because its return value is
cast to void:

security/smack/smackfs.c:init_smk_fs() {
    ...
	(void) smk_cipso_doi(SMACK_CIPSO_DOI_DEFAULT,
			     GFP_KERNEL | __GFP_NOFAIL);
    ...
}

Writes to /smack/doi return -ENOSYS through this path:

smk_write_doi()->smk_cipso_doi()->netlbl_cfg_cipsov4_add()->cipso_v4_doi_add()

Could the commit message mention this change in Smack's behaviour?

> diff --git a/net/netlabel/Kconfig b/net/netlabel/Kconfig
> index 4383ac29693ec..bcc27196d5bd7 100644
> --- a/net/netlabel/Kconfig
> +++ b/net/netlabel/Kconfig
> @@ -17,3 +17,7 @@ config NETLABEL
>  	   * https://github.com/netlabel/netlabel_tools
>  
>  	  If you are unsure, say N.
> +
> +config CIPSO
> +	def_bool y
> +	depends on NETLABEL && IPV4
> diff --git a/net/netlabel/Makefile b/net/netlabel/Makefile
> index 5a46381a64e77..8afc1bf004243 100644
> --- a/net/netlabel/Makefile
> +++ b/net/netlabel/Makefile
> @@ -12,5 +12,5 @@ obj-y	+= netlabel_mgmt.o
>  
>  # protocol modules
>  obj-y	+= netlabel_unlabeled.o
> -obj-y	+= netlabel_cipso_v4.o
> +obj-$(CONFIG_CIPSO) += netlabel_cipso_v4.o
>  obj-$(subst m,y,$(CONFIG_IPV6)) += netlabel_calipso.o
> diff --git a/net/netlabel/netlabel_cipso_v4.h b/net/netlabel/netlabel_cipso_v4.h
> index 9518ab56ec98f..fb718f86bcbd7 100644
> --- a/net/netlabel/netlabel_cipso_v4.h
> +++ b/net/netlabel/netlabel_cipso_v4.h
> @@ -147,6 +147,13 @@ enum {
>  #define NLBL_CIPSOV4_A_MAX (__NLBL_CIPSOV4_A_MAX - 1)
>  
>  /* NetLabel protocol functions */
> +#if IS_ENABLED(CONFIG_CIPSO)
>  int netlbl_cipsov4_genl_init(void);
> +#else
> +static inline int netlbl_cipsov4_genl_init(void)
> +{
> +	return 0;
> +}
> +#endif

[Severity: Medium]
With CIPSO=n, this stub returns 0 and does not register the NLBL_CIPSOv4
generic netlink family. Should netlbl_mgmt_protocols() in
net/netlabel/netlabel_mgmt.c stop listing CIPSOv4 in that case? It still
lists it with no config check:

net/netlabel/netlabel_mgmt.c:netlbl_mgmt_protocols() {
    ...
	if (protos_sent == 1) {
		if (netlbl_mgmt_protocols_cb(skb,
					     cb,
					     NETLBL_NLTYPE_CIPSOV4) < 0)
			goto protocols_return;
		protos_sent++;
	}
#if IS_ENABLED(CONFIG_IPV6)
	if (protos_sent == 2) {
    ...
}

So an NLBL_MGMT_C_PROTOCOLS dump (for example, "netlabelctl mgmt
protocols") would report CIPSOv4 as supported on a kernel that cannot
use it.

Any attempt to set up a CIPSOv4 mapping through the management interface
then fails with -EINVAL. The cipso_v4_doi_getdef() stub always returns
NULL:

net/netlabel/netlabel_mgmt.c:netlbl_mgmt_add_common() {
    ...
	case NETLBL_NLTYPE_CIPSOV4:
		...
		cipsov4 = cipso_v4_doi_getdef(tmp_val);
		if (cipsov4 == NULL)
			goto add_free_domain;
    ...
}

The kapi path, netlbl_cfg_cipsov4_map_add(), returns -ENOSYS for the same
case.

The CALIPSO entry is wrapped in IS_ENABLED(CONFIG_IPV6), which matches
how netlabel_calipso.o is built.

The dump resume cursor uses fixed indices, and CALIPSO is only sent when
protos_sent == 2. Wrapping the CIPSOv4 block in #if IS_ENABLED(CONFIG_CIPSO)
on its own would mean CALIPSO is never sent when CIPSO=n. Would the cursor
handling need to change as well?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260928193046.6698-1-fmancera%40suse.de
