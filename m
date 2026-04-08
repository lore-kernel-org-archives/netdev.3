Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7191298CAF
	for <netdev@vger.kernel.org>; Wed,  8 Apr 2026 09:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775640774; cv=none; b=txkfS1kGJzWog56fYeb6AE5MdGql3XzqmSkiWz7R/nlZwtDwkgpEJ4KkxUZUPZOfwmVoUnGelxk55WLOYU85d0QybVG40uqdVOohw8v2Vvjv3pHJYKncPRJ215He/9DhXALEWgBszOl85uSmEJvsi4YLWs2w5w8c0daWba54vno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775640774; c=relaxed/simple;
	bh=ISBB0PVEaGBosAfINee5ozPon7KUFv8GrTIFmVu8XX8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZEZPPTmg1s7hFSUkWVp/89xLZlX796L4VSY1z0PwDpKZGH535M9lNeHappTNWLiCpvM7JyqVVjrVsH05sHdhpwCzlBl7TCqLtLJ+gDWHmDHcaSmFoSUNgjCw3VbGhZF2IwREX67tkTcfpI3KjW9wKhKmvuwJACeKO6AV8yvVJpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Nyi9lBvl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nyi9lBvl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775640771;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0WLLaDR4hBeJBSOXLWkUCGw0FfU9RJNtZTAtzZEXwZg=;
	b=Nyi9lBvlR87Ww/CMLCWX2T3DZXkLaXxTZJnLU4axLWtUHETO6uE//2RXYhIKq/ERC+Yd3g
	LNV8Y0jS0ZMQA0K8qQaDdFJQ5U6D/0qbvuNbEk3ihSq8wdyakqTQ8rx2EO+BehCTt7eES8
	/sCSs0LvXT+Y+DA40m4GUHrx5LII4Eo=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-56-drptm72mPCKJcq05h3RU6g-1; Wed,
 08 Apr 2026 05:32:50 -0400
X-MC-Unique: drptm72mPCKJcq05h3RU6g-1
X-Mimecast-MFC-AGG-ID: drptm72mPCKJcq05h3RU6g_1775640769
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0532918002E7;
	Wed,  8 Apr 2026 09:32:49 +0000 (UTC)
Received: from thinkpad (unknown [10.44.33.70])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9056F300019F;
	Wed,  8 Apr 2026 09:32:46 +0000 (UTC)
Date: Wed, 8 Apr 2026 11:32:43 +0200
From: Felix Maurer <fmaurer@redhat.com>
To: luka.gejak@linux.dev
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org, horms@kernel.org,
	fmancera@suse.de
Subject: Re: [PATCH net-next v5 1/2] net: hsr: require valid EOT supervision
 TLV
Message-ID: <adYgjqxUsX13Nabt@thinkpad>
References: <20260407162502.19462-1-luka.gejak@linux.dev>
 <20260407162502.19462-2-luka.gejak@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260407162502.19462-2-luka.gejak@linux.dev>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Tue, Apr 07, 2026 at 06:25:01PM +0200, luka.gejak@linux.dev wrote:
> From: Luka Gejak <luka.gejak@linux.dev>
>
> Supervision frames are only valid if terminated with a zero-length EOT
> TLV. The current check fails to reject non-EOT entries as the terminal
> TLV, potentially allowing malformed supervision traffic.
>
> Fix this by strictly requiring the terminal TLV to be HSR_TLV_EOT
> with a length of zero, and properly linearizing the TLV header before
> access.
>
> Assisted-by: Gemini:Gemini-3.1-flash
> Signed-off-by: Luka Gejak <luka.gejak@linux.dev>

Thanks for the patch, including making sure that there is enough data
available to read the next TLVs.

Reviewed-by: Felix Maurer <fmaurer@redhat.com>

> ---
>  net/hsr/hsr_forward.c | 20 +++++++++-----------
>  1 file changed, 9 insertions(+), 11 deletions(-)
>
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
>
> --
> 2.53.0
>

