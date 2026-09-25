Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF067346E58
	for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 17:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790359183; cv=none; b=oE79tsp9vdUTVh8nNYbldw0BG1jLHMzFHXhdqcBx1vDsFdaA78Yk6UAS9jNR9ntYXawdK9sWlw8KSpFwjlsyP4RrJHGsWAuF/0k2hW2PF9+v3DxjZfYXMjNfMxChcjRx/kcgn4q3+34v1NMQpXipy9pPr0BhdjgdrqvnzVgg0tM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790359183; c=relaxed/simple;
	bh=07mCo+XxSbyEQxKynJxn11UmQWZ/kELvDFPvp/A2H50=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jEKmP+W/5R0NZad02+PDIDMQLD9/Z8MCYgCpZSygMAGe8ElhxabWfwuOFjy83RJEu4vfmur6DUoPFQV7dJw9YKCIDo87Dw1obYNvuhXBiL7FXsN9tC/Q8STYYDVPUxaMHDXoYUzu8JJS7oYcTp6H7R/O60PmIGss/yvPnchdmhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JvKYe1hY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JvKYe1hY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790359180;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3H2tJ/7lt2dj6BTQfoqnPD2h5VHn7sSRmzuUdDux1Xo=;
	b=JvKYe1hYqO650u56/vJChN221sBhtQqyhGi27Zj+bNKTpJMbrheUeRyBUU9BwAEO+7Z3kf
	RopWQJd8bPnrcjlLAIwhpSr11Itl7Y/4a+ODHetJFvrNNkF4/sZDW7PCSeB7R3yNSJtXsv
	0Pyl7OavGM8v7snfRXvcO4TmNwKreFs=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-515-ed5L-5jPOVuBnI6HTTev8Q-1; Fri,
 25 Sep 2026 13:59:37 -0400
X-MC-Unique: ed5L-5jPOVuBnI6HTTev8Q-1
X-Mimecast-MFC-AGG-ID: ed5L-5jPOVuBnI6HTTev8Q_1790359176
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C2507195FD0B;
	Fri, 25 Sep 2026 17:59:35 +0000 (UTC)
Received: from [100.90.87.156] (headnet03.pony-001.prod.iad2.dc.redhat.com [10.2.32.114])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6C54B180034C;
	Fri, 25 Sep 2026 17:59:32 +0000 (UTC)
Message-ID: <702b7b8a-d9a2-4ceb-9013-b94aeaf85ee8@redhat.com>
Date: Fri, 25 Sep 2026 19:59:31 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/3] dpll: do not truncate the requested pin
 frequency before checking it
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, vadim.fedorenko@linux.dev,
 arkadiusz.kubalewski@intel.com, jiri@resnulli.us, donald.hunter@gmail.com
References: <20260924231211.568213-1-kuba@kernel.org>
 <20260924231211.568213-2-kuba@kernel.org>
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <20260924231211.568213-2-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On 9/25/26 1:12 AM, Jakub Kicinski wrote:
> DPLL_A_PIN_FREQUENCY is a u64 on the wire and dpll_pin_freq_set() keeps it
> as one, but dpll_pin_is_freq_supported() takes a u32 while the ranges it
> compares against are u64. The supported-frequency check therefore only
> looks at the low 32 bits, and the full value is what reaches the driver.
> 
> Nothing is hitting this today. Reaching it at all needs a pin-set above
> U32_MAX, which no sane caller sends, and the outcome is mild: a pin
> advertising 10 kHz accepts 0x1_0000_2710, ice narrows it straight back to
> 10 kHz in ice_dpll_pin_freq_set(), so the hardware still ends up on an
> advertised frequency and only the "frequency is not supported by the
> device" rejection goes missing. The other direction - a legitimate request
> above U32_MAX wrapping out of the pin's range - needs a driver advertising
> such a range, and none does; zl3073x_pin_check_freq() refuses one outright.
> 
> So this is types rather than a live bug. Widen the check to match the
> attribute, the ranges and the driver callback instead of adding a U32_MAX
> rejection, so that the second case stays right if such a driver appears.
> dpll_pin_esync_set() already keeps u64 throughout its equivalent loop.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>   drivers/dpll/dpll_netlink.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/dpll/dpll_netlink.c b/drivers/dpll/dpll_netlink.c
> index fb24fd53f2e1..e5380d95f238 100644
> --- a/drivers/dpll/dpll_netlink.c
> +++ b/drivers/dpll/dpll_netlink.c
> @@ -608,7 +608,7 @@ dpll_msg_add_pin_ref_sync(struct sk_buff *msg, struct dpll_pin *pin,
>   	return -EMSGSIZE;
>   }
>   
> -static bool dpll_pin_is_freq_supported(struct dpll_pin *pin, u32 freq)
> +static bool dpll_pin_is_freq_supported(struct dpll_pin *pin, u64 freq)
>   {
>   	int fs;
>   

Reviewed-by: Ivan Vecera <ivecera@redhat.com>

