Received: from mta1.formilux.org (mta1.formilux.org [51.159.59.229])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE2AB48A2A9
	for <netdev@vger.kernel.org>; Fri,  9 Oct 2026 08:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.159.59.229
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791532943; cv=none; b=iKUDvGx/jWoQ1z1KKHfmiLqEzntda6cK5URymjkoVWLxtds0/54avqDFm84BfrtNzfnRwnk5KX/QFDCUtP9iz/bfwYvhVdAByePQl1SAKBIrwdwMNmeLJEYxDxtkknrYzxH3R1n6UQVQaYpJNnBKxTadgZtBiSkZI9UD2w3Vcdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791532943; c=relaxed/simple;
	bh=vmi5PqJfNrvwJ6x46yVERRyFGPBY9Jj8PP4VofWQbOY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fsI5i41qEWLa+9idhdDiuPC8I3pYAEr/dC+DbFpZL/hhZaG2QMDD6k1CDQFv+L4qlcouid2kuXJwuKXf3hs5CZ8wCbwL+wuhRqfwxSG7uBVbbVoAMOGCgLrWNLLyqrxea0MkNhpKIXUj8Zr1qtWpGYfvalWhrl+wec/FBxk4oBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=1wt.eu; spf=pass smtp.mailfrom=1wt.eu; dkim=pass (1024-bit key) header.d=1wt.eu header.i=@1wt.eu header.b=JN+czI5F; arc=none smtp.client-ip=51.159.59.229
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=1wt.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1wt.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=1wt.eu header.i=@1wt.eu header.b="JN+czI5F"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1wt.eu; s=mail;
	t=1791532930; bh=IgOq+wft5AZMG0uX4btZmOLXgEDDljOkhhKxL31F9WU=;
	h=From:Message-ID:From;
	b=JN+czI5FUq0TrFFmpHe2VMXfnT8vlOeYMyfKTyOfMuREONmHhC5O3dZ+0bke9q1/9
	 E9YAFd8FjbscbSna5n8wUeu4hrZZlu0B3Tr96On89w8iSYNGoebFKWwpGTxaB5bLK2
	 gHuFdUN1GZ1lJSzoUJTgYxncEt9BqIJYahkQvugI=
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by mta1.formilux.org (Postfix) with ESMTP id C67E9C090D;
	Fri, 09 Oct 2026 10:02:10 +0200 (CEST)
Date: Fri, 9 Oct 2026 10:02:10 +0200
From: Willy Tarreau <w@1wt.eu>
To: Nikhil Agrawal <nikhil.agrawal@mettlelabs.ai>
Cc: security@kernel.org, sam@mendozajonas.com, netdev@vger.kernel.org
Subject: Re: [SECURITY] net/ncsi: Bound mac_cnt and vlan_cnt in
 ncsi_rsp_handler_gp() (ZERO-284)
Message-ID: <asifgiumTIKuzFAs@1wt.eu>
References: <CALMgpqZq5i1Zy0ucS_HGgEPFFuTTN7siwEg7rdSU9XVvXz0xow@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALMgpqZq5i1Zy0ucS_HGgEPFFuTTN7siwEg7rdSU9XVvXz0xow@mail.gmail.com>

Hello,

Note, there's no need to Cc security@k.o when sending to public
lists.

On Fri, Oct 09, 2026 at 12:44:48PM +0530, Nikhil Agrawal wrote:
> Hello Linux Kernel Security Team and NC-SI maintainers,
> 
> I am Nikhil, a YC founder, and along with our security research team at
> Mettle Labs, we have been conducting systematic defensive code audits
> across the Linux networking subsystem.
> 
> During our audit of the NC-SI (Network Controller Sideband Interface)
> stack, we uncovered a remote heap buffer overflow in `net/ncsi/ncsi-rsp.c`
> reachable from a compromised or malicious BMC sideband interface.
> 
> Below are the technical findings, dataflow analysis, and a patch ready for
> upstream review.
> 
> ===================================================================
> 1. Vulnerability Summary
> ===================================================================
> In `net/ncsi/ncsi-rsp.c`, `ncsi_rsp_handler_gp()` processes
> `GET_PARAMETERS` responses. The function parses MAC and VLAN filter lists
> from the response frame and copies them into driver arrays (`ncmf->addrs`
> and `ncvf->vids`).
> 
> The buffers `ncmf->addrs` and `ncvf->vids` are allocated during
> `ncsi_rsp_handler_gc()` sized strictly from the counts returned in the
> `GET_CAPABILITIES` (GC) response. However, `ncsi_rsp_handler_gp()` uses
> `rsp->mac_cnt` and `rsp->vlan_cnt` from the subsequent `GET_PARAMETERS`
> response to drive its copy loops without verifying that these counts fit
> within the allocated buffer sizes.
> 
> A malicious or compromised BMC responding on the sideband interface can
> provide `mac_cnt` or `vlan_cnt` values exceeding the allocated capacities
> (e.g. `mac_cnt = 255`), causing an out-of-bounds slab heap write of
> attacker-controlled MAC/VLAN data (~1500 bytes into kmalloc heap).
> 
> ===================================================================
> 2. Affected Code & Root Cause
> ===================================================================
> Location: `net/ncsi/ncsi-rsp.c` (around line 892)
> 
> ```c
> static int ncsi_rsp_handler_gp(struct ncsi_request *nr)
> {
>     ...
>     for (i = 0; i < rsp->mac_cnt; i++) {
>         pdata = (unsigned char *)rsp + 48 + i * 8;
>         memcpy(&ncmf->addrs[i * ETH_ALEN], pdata, ETH_ALEN);
>     }
>     ...
>     for (i = 0; i < rsp->vlan_cnt; i++) {
>         pdata = (unsigned char *)rsp + 48 + rsp->mac_cnt * 8 + i * 4;
>         ncvf->vids[i] = ntohs(*(__be16 *)pdata);
>     }
> ```
> 
> Because `ncmf->addrs` was allocated in `ncsi_rsp_handler_gc()` sized to
> `(uc_cnt + mc_cnt + mixed_cnt) * ETH_ALEN`, if `rsp->mac_cnt` exceeds this
> sum, `memcpy()` writes past the buffer boundary. Furthermore, filter
> bitmaps are fixed 64-bit masks (`u64`), so counts over 64 cause bitfield
> operations in `ncsi-manage.c` to walk past the u64 boundary.
> 
> ===================================================================
> 3. Proposed Patch
> ===================================================================
> From: Nikhil Agrawal <nikhil@mettlelabs.ai>
> Subject: [PATCH] net/ncsi: Bound mac_cnt and vlan_cnt in
> ncsi_rsp_handler_gp()
> 
> In ncsi_rsp_handler_gp(), the driver copies MAC and VLAN filter entries
> from the GET_PARAMETERS response into allocated arrays (ncmf->addrs and
> ncvf->vids). The loop boundaries currently use the counts supplied in the
> response frame (rsp->mac_cnt and rsp->vlan_cnt) without bounding them
> against the buffer sizes allocated during ncsi_rsp_handler_gc().
> 
> If a response specifies more MAC or VLAN entries than were allocated,
> the loops overflow the slab buffers.
> 
> Bound rsp->mac_cnt and rsp->vlan_cnt to the allocated filter capacities,
> and check for null buffers.
> 
> Fixes: e6f449a37b9b ("net/ncsi: Add support for NCSI 1.1")
> Cc: stable@vger.kernel.org
> Reported-by: Mettle Labs Security Team <security@mettlelabs.ai>
> Signed-off-by: Nikhil Agrawal <nikhil@mettlelabs.ai>

Same comments as for your other patches.

> ---
>  net/ncsi/ncsi-rsp.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/net/ncsi/ncsi-rsp.c b/net/ncsi/ncsi-rsp.c
> index e1a2b3c..d4e5f6a 100644
> --- a/net/ncsi/ncsi-rsp.c
> +++ b/net/ncsi/ncsi-rsp.c
> @@ -880,6 +880,14 @@ static int ncsi_rsp_handler_gp(struct ncsi_request *nr)
>   return -EINVAL;
> 
>   ncmf = &nc->mac_filter;
> + if (!ncmf->addrs)
> + return -EINVAL;
> + if (rsp->mac_cnt > (ncmf->n_uc + ncmf->n_mc + ncmf->n_mixed))
> + return -EINVAL;
> +
> + ncvf = &nc->vlan_filter;
> + if (rsp->vlan_cnt && (!ncvf->vids || rsp->vlan_cnt > ncvf->n_vids))
> + return -EINVAL;
> 
>   for (i = 0; i < rsp->mac_cnt; i++) {
>   pdata = (unsigned char *)rsp + 48 + i * 8;

Same space mangling that needs fixing.
> -- 
> 
> ===================================================================
> 4. Coordination
> ===================================================================
> We adhere strictly to the Linux kernel 7-day coordinated disclosure policy.
> Please let us know if any further details or traces are needed.

Since you sent to a public list there's no disclosure involved.

> Best regards,
> Nikhil Agrawal
> Mettle Labs
> mettlelabs.ai

Willy
