Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4916D37CD5F
	for <netdev@vger.kernel.org>; Sun, 12 Apr 2026 19:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776023160; cv=none; b=jM5oUsfJUsmkhCNYG0MnfQ7zx3R6qolhl+BntWksW8wnpiEgg6pJvfrAzYKR73i9IR5JlR97fs9hvI3nAWb86gjYiJbvt6br98WAuDtjDS5thhhi9iILS5JvICq5nTDMEys+lt29LyuXfyzC+4wlEpQ9zOd+nFmeXaXPAs/oRWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776023160; c=relaxed/simple;
	bh=jXRK/QotpaPsxLE94Fyq0ZR025OZ6WN4svZ1rVBKF2M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g8tbOX5LHjMLo2UdxWDdwcvPBNdyUIosMgExr7em+hAvOwBgWhyczJV6pCzn/9nOKhZN4WVbMs4sSHJpUgtryLNbHp5t/TrXSOcwJ1LtgJ7G9c5sDR2mqfu35lZ+UAkqVralCYDTd2ERA9XxVUZzheHKyO6uB1L/6gsGu8yt7AU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rk6BDq48; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rk6BDq48"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B8AAC19424;
	Sun, 12 Apr 2026 19:45:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776023159;
	bh=jXRK/QotpaPsxLE94Fyq0ZR025OZ6WN4svZ1rVBKF2M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rk6BDq48xgd/pPS4/hEd0GriSkMwTnD00EUuxxAwMueV9FXQUmMol7maU9p+NgLAA
	 1LpnFVCca4AjJUa5PADKcrD70ElaZmHrZoCWWO0cig/VLLT61s0+63Am2Hculnps/z
	 /0Rg2DcQrgZbjxddDuOhtyvjanKLeEtqS0vHyXtW8IdosySrc53y7KhL0B0jD460qm
	 PGf034Gj+/KStcOMvpb8DG2TMj+CT85bxHr5uWja2Pv7SKyqSaQhe4a+gSo/6eHJdd
	 uLdpTUmXxJW6xUCVs/YWrwZOA9sKwYI31MxnyO+Fl7BewFvo5G3Khuw5drNmuCiq/0
	 XAt+Bf6OKgE+A==
Date: Sun, 12 Apr 2026 12:45:58 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: luka.gejak@linux.dev
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 netdev@vger.kernel.org, fmaurer@redhat.com, horms@kernel.org
Subject: Re: [PATCH net-next v5 1/2] net: hsr: require valid EOT supervision
 TLV
Message-ID: <20260412124558.190c725f@kernel.org>
In-Reply-To: <20260407162502.19462-2-luka.gejak@linux.dev>
References: <20260407162502.19462-1-luka.gejak@linux.dev>
	<20260407162502.19462-2-luka.gejak@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  7 Apr 2026 18:25:01 +0200 luka.gejak@linux.dev wrote:
> From: Luka Gejak <luka.gejak@linux.dev>
> 
> Supervision frames are only valid if terminated with a zero-length EOT
> TLV. The current check fails to reject non-EOT entries as the terminal
> TLV, potentially allowing malformed supervision traffic.
> 
> Fix this by strictly requiring the terminal TLV to be HSR_TLV_EOT
> with a length of zero, and properly linearizing the TLV header before
> access.

> diff --git a/net/hsr/hsr_forward.c b/net/hsr/hsr_forward.c
> index 0aca859c88cb..eb89cc44eac0 100644
> --- a/net/hsr/hsr_forward.c
> +++ b/net/hsr/hsr_forward.c
> @@ -82,35 +82,33 @@ static bool is_supervision_frame(struct hsr_priv *hsr, struct sk_buff *skb)
>  	    hsr_sup_tag->tlv.HSR_TLV_length != sizeof(struct hsr_sup_payload))
>  		return false;
>  
> -	/* Get next tlv */
> +	/* Get next TLV */

The capitalization of the comments makes the real changes in this patch
harder to spot and follow. Please don't tweak the comments unless you're
really changing / improving them.

>  	total_length += hsr_sup_tag->tlv.HSR_TLV_length;
> -	if (!pskb_may_pull(skb, total_length))
> +	if (!pskb_may_pull(skb, total_length + sizeof(struct hsr_sup_tlv)))
>  		return false;
>  	skb_pull(skb, total_length);
>  	hsr_sup_tlv = (struct hsr_sup_tlv *)skb->data;
>  	skb_push(skb, total_length);
>  
> -	/* if this is a redbox supervision frame we need to verify
> -	 * that more data is available
> -	 */
> +	/* If this is a RedBox supervision frame, verify additional data */
>  	if (hsr_sup_tlv->HSR_TLV_type == PRP_TLV_REDBOX_MAC) {
> -		/* tlv length must be a length of a mac address */
> +		/* TLV length must be the size of a MAC address */
>  		if (hsr_sup_tlv->HSR_TLV_length != sizeof(struct hsr_sup_payload))
>  			return false;
>  
> -		/* make sure another tlv follows */
> +		/* Make sure another TLV follows */
>  		total_length += sizeof(struct hsr_sup_tlv) + hsr_sup_tlv->HSR_TLV_length;
> -		if (!pskb_may_pull(skb, total_length))
> +		if (!pskb_may_pull(skb, total_length + sizeof(struct hsr_sup_tlv)))
>  			return false;
>  
> -		/* get next tlv */
> +		/* Get next TLV */
>  		skb_pull(skb, total_length);
>  		hsr_sup_tlv = (struct hsr_sup_tlv *)skb->data;
>  		skb_push(skb, total_length);
>  	}
>  
> -	/* end of tlvs must follow at the end */
> -	if (hsr_sup_tlv->HSR_TLV_type == HSR_TLV_EOT &&
> +	/* Supervision frame must end with EOT TLV */
> +	if (hsr_sup_tlv->HSR_TLV_type != HSR_TLV_EOT ||
>  	    hsr_sup_tlv->HSR_TLV_length != 0)
>  		return false;

Aren't there more optional TLVs that we don't support?
You mentioned making sure that the final TLV is a zero-length EOT
but this check is far stricter.

Should we replace this check with a loop which skips over TLVs
until EOT is reached?
-- 
pw-bot: cr
