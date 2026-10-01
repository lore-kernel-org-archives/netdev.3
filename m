Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C1E8494838
	for <netdev@vger.kernel.org>; Thu,  1 Oct 2026 07:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790839466; cv=none; b=X0EI/fk2VUDeL6Hn3tpEoZl+nqB2WLts6vxXDmdy4qv3Puqt+FFU9tsHgD0BkhoV8uCOUDCcf3FAUx+aj4UWmbPCY1AQUAYRSbnNac0gncr3WyrIYPwDHZj2G9/+0yIMxKWnavOU2CRHmiApsktq3DTzKfh95AXH7J1C5s5GBW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790839466; c=relaxed/simple;
	bh=+kzzhS5v66EKTlw3lUPtyrJFzB9cfI2ObH/53846yGY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P5nV7eCgBOn1+HGgEc55KvF6gtWuxSeM4ATXpSnhxQIjzDT0OsqFn75vTMS3Egdj2Zb7eZ3mhwdCl0QwXd9cxvIRMNHwiWEDUnCk2/Xp12CsXGwS/rvRYkUo/nB8hBKRiJIjTGKYZOq3qZrGu7PhD/M0WIkb/reDfd9s3pAEIcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=W5eoCsaU; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="W5eoCsaU"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49b912d822dso45694295e9.2
        for <netdev@vger.kernel.org>; Thu, 01 Oct 2026 00:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1790839458; x=1791444258; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=mQWMGiVWN/VMdfjyxv3PjkOZ115osD80NYmANMAtXcY=;
        b=W5eoCsaUdoH5mcgKR3w9JHCbRYmE0r19Bkpfm5v4ysGvkP0EDu4taDF25k9qwOjp9I
         XGlUOAQCqD7NJK0x8GYeFJ7KT7eBZgi86jZru/3ctUq6zyzINU/Ym4QJos4W3Kx+jSs/
         0OqNGvW/n7s/gSlPmgnc31QvcsQRTGUQs6bmkjkPKtx3V8jcav1r0REQ2kWXqF3uvp76
         tUSEY1XC18im8IKy6i7XEotfVoLYL+sgoTzRymqJHFhgh0O3AoOFc9vKA/90xZUic+E9
         kmzSxsk0xnPpBerQDmU9oncjl090bJefuo6yR1lRpvfDKkYgt82gGuLS38rRUms0kWYu
         Lc5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790839458; x=1791444258;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mQWMGiVWN/VMdfjyxv3PjkOZ115osD80NYmANMAtXcY=;
        b=jtNbQaC1gf8M3fUpHs+LyblCwaYLt3h3gnTMHmHNDwfz4/wtowbjCC1WVJi5BVl1ow
         Dn1DFBG9WMXcn6p9KsEQbcqc1GrjiJ7DiKE+Yok4612VzOR0UCkzCZM+qWJZi68nNztZ
         DSZpHT/5ZeAbxB+Rzd4KiQBb8nbtGS/y8ELveSLriKJGkZmigRmyxDMT3xim0eJJyZWE
         IQRDPKYcY0vMzN6VKpGkRvkha3U0k6iX1/5w48ivzWp6OM7FcZCmN03SMGumStyiyaxQ
         dV3vZji7Hy0ZB/JdjQVDJaZvYZq45XrNC68jfmtiMsmWT312srirUYV8Q8+ZKxsLE70M
         AJdA==
X-Gm-Message-State: AFuF++kY4CCLe0C61p2J+D/NSHQbKc1bVpaznnKMZqr6QRisVTH9o6zA
	mC8wApZ+tIasb3BNqPPjHw3728AZQkIPyN5I6+mjQcq1OYtORC6qN4AAkDhEWWVxy60XnlIpOdK
	64gMyFq0=
X-Gm-Gg: AYBFou3xwpb7iWus6Jdes9i7/L5qh5c2YGm2mWTdDTuliUJymzPbr6VADcs+Nx0h0Sb
	WlB6XsnULc1hroc86nBNe4+wYuu9XJJsE+/pInXbDaHa8Xxf6B0c9TmXSzTvteePc/PdKzvsOw7
	I0LHPdw9lFS5++M2fq1BtVYOVSdI2R2dxDJDsUanmrzSXmeyMXW8VcPTXFiCqGBI04m7dzQvhNA
	37s59RiRY2kCZlbo5GJcGz97wfEbY/O6Rxvdeeb4gHMPMEF235qIJSIt+VfEptXCOEUa1PYobiN
	+k1gXZuuPxH4Z1ctzfQYddADoZuwCpftGmV+zMMmYGgjMfla/EwB0XGQwh2XLYyuHAqzRxEXu4m
	QzHMnVoBoTKRjUVzGmck7JB6vopcCy+jhXDqIohHRzifUDvQw1cp2itzJbxWTA8zv/RSAIS6Q9X
	raY16SH7YcnHf8UPYDzpK9aATKpz9AO9IBmEseiIqqf1C92vYeC+brVB5XfX6bWPUzbj69YtRcZ
	zgGE/pE3S0H4iY3M1OdoiFeTWAF
X-Received: by 2002:a05:600c:1c0d:b0:49c:fa21:1c81 with SMTP id 5b1f17b1804b1-4a01aff36b2mr71267215e9.22.1790839457379;
        Thu, 01 Oct 2026 00:24:17 -0700 (PDT)
Received: from [192.168.0.161] (78-154-14-127.ip.btc-net.bg. [78.154.14.127])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a01f90cd4esm62840435e9.1.2026.10.01.00.24.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Oct 2026 00:24:16 -0700 (PDT)
Message-ID: <e930a549-9b26-4e5d-bdac-ec80537b6306@blackwall.org>
Date: Thu, 1 Oct 2026 10:24:15 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 01/12] net: bridge: introduce a bridge
 destination type
Content-Language: en-US, bg
To: netdev@vger.kernel.org
Cc: idosch@nvidia.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, bridge@lists.linux.dev
References: <20260930071411.2786201-1-razor@blackwall.org>
 <20260930071411.2786201-2-razor@blackwall.org>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20260930071411.2786201-2-razor@blackwall.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 30/09/2026 10:14, Nikolay Aleksandrov wrote:
> Add an opaque destination type and helpers for representing bridge port
> destinations. Using a separate structure makes raw pointer assignments and
> comparisons fail at build time while marking its value member __private
> makes sparse warn about accesses that bypass the helpers.
> 
> Reviewed-by: Ido Schimmel <idosch@nvidia.com>
> Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>
> ---
>   net/bridge/br_private.h | 38 ++++++++++++++++++++++++++++++++++++++
>   1 file changed, 38 insertions(+)
> 
> diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
> index 67117fb3dc88..1146187aa2ba 100644
> --- a/net/bridge/br_private.h
> +++ b/net/bridge/br_private.h
> @@ -306,6 +306,10 @@ struct net_bridge_fdb_key {
>   	u16 vlan_id;
>   };
>   
> +struct net_bridge_dst {
> +	unsigned long __private value;
> +};
> +
>   struct net_bridge_fdb_entry {
>   	struct rhash_head		rhnode;
>   	struct net_bridge_port		*dst;
> @@ -670,6 +674,40 @@ struct br_input_skb_cb {
>   #define br_debug(br, format, args...)			\
>   	pr_debug("%s: " format,  (br)->dev->name, ##args)
>   
> +static inline struct net_bridge_dst
> +br_dst_read(const struct net_bridge_dst *src)
> +{
> +	struct net_bridge_dst dst;
> +
> +	ACCESS_PRIVATE(&dst, value) =
> +		READ_ONCE(ACCESS_PRIVATE(src, value));
> +
> +	return dst;
> +}
> +
> +static inline void br_dst_write(struct net_bridge_dst *dst,
> +				struct net_bridge_dst src)
> +{
> +	WRITE_ONCE(ACCESS_PRIVATE(dst, value),
> +		   ACCESS_PRIVATE(&src, value));
> +}
> +
> +static inline struct net_bridge_dst
> +br_port_to_dst(const struct net_bridge_port *p)
> +{
> +	struct net_bridge_dst dst;
> +
> +	ACCESS_PRIVATE(&dst, value) = (unsigned long)p;
> +


Sashiko says:
  Does casting this const-qualified struct net_bridge_port pointer to an
  unsigned long drop the const restriction?

  - Yes, it does but that is expected.

> +	return dst;
> +}
> +
> +static inline struct net_bridge_port *
> +br_dst_port(struct net_bridge_dst dst)
> +{
> +	return (struct net_bridge_port *)ACCESS_PRIVATE(&dst, value);
> +}

Sashiko says:
  When the opaque token from br_port_to_dst() is resolved here in
  br_dst_port(), is it unconditionally cast back to a mutable
  struct net_bridge_port pointer?
  Could this provide a silent mechanism to cast away const, bypassing C type
  safety constraints in the API design?

  - That is again expected and wanted behaviour, we're extracting the dst.


> +
>   /* called under bridge lock */
>   static inline int br_is_root_bridge(const struct net_bridge *br)
>   {

