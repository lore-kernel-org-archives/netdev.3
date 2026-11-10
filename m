Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794324674;
	b=hEe+t7000qzR7gOAib2ixghK2uly4P6cSci9hHdg4wOwZJ13onqT7Xx9jf3kxsXQU9BP
	 nWssNd4W5bplW6rUJl/TpOzOouM3GSybnh6XmOoOo3izKlSxMprVfQpe3bMoZHx1/y3PO
	 h4MK0d7hVeN7hEWYqn1WIKgYDygQ1lyd6Oe0u9wRmZl0JP7dLkDMIvujJBpwAI47mJNFD
	 Zm7ivgF1l+aeDbVHBMYJ1/DEYTB851PVjqqhFwspgQY+z2Bso6PWV3CF3nsDXGs3XkD/o
	 R1QpyyskO8yd9rA+UKhWNQfNLVrsEITr0ImuqKr+WmuMTgsw9eh35HZEPrmAofxU6ww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794324674;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 Content-Language:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=gXjqAYmOZzBpoVOClTeMCf3Fr5RoD9/tZaRkMD38hnw=;
	b=hV7c58EXpH/bwGLYHOF1HeDju4liMVFq2/l9Xuesvij2KJI3HaWPPB/pa/UnJmAmwA7g
	 HVulg+rCoBHRbKVnDlKrShsuYiK1YirHF2Ua8RpqvsQQQkELTJBkgJZ1f3o+4CRL0jlut
	 A1d1aaXXNKFG0YQg9kJukHqQzt3C9cXrs5HJ00p2BHQyFgCeplTcj0DcDZD2ExZgvdd2g
	 wzSP2dp8StJ2hCaRsfG2M4m5XeM6neIY/yNGqzDvC//16fBsO/YUc32V8wCQmhtkTXFsY
	 0OTQ7Mu2t1Ujng9DBYDNDOcnaQ+okFHtz7aIcGRvmF0f6y4aIIguxQzzgEY0fUsSnvQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=i2dxizgQ;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=o2DRGKwa;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B5DE60A2617
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 15:31:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6B5DE60A2617
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=i2dxizgQ;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=o2DRGKwa
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794324672;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gXjqAYmOZzBpoVOClTeMCf3Fr5RoD9/tZaRkMD38hnw=;
	b=i2dxizgQD4d47DWGGU3oj8PATKTlR4iEwYSPLmhxne3JX9CfIjoSK67VxHqVW0dONVL9cl
	qmLRyTw2QXrtChSNRQwV00xaRPCJZbYeC5sYBZsc0D2LgmxYbrix3HwU3hPzE4mDZ7p1UP
	CaLQzUFbe/qtBl3bj2aXRF0sF8tT1xg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-282-KXaQupRvOc6LcgBCyEv3hQ-1; Tue, 10 Nov 2026 10:31:08 -0500
X-MC-Unique: KXaQupRvOc6LcgBCyEv3hQ-1
X-Mimecast-MFC-AGG-ID: KXaQupRvOc6LcgBCyEv3hQ_1794324667
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4ba01393800so9133075e9.1
        for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 07:31:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1794324667; x=1794929467; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=gXjqAYmOZzBpoVOClTeMCf3Fr5RoD9/tZaRkMD38hnw=;
        b=o2DRGKwamIrWbnBK8ZAYCOGE6SW95LqzSGt7qtdluNDesOZ5jy4HWjJJUYO3RlAtMY
         p2LKWjmpdnr8AvjY8atM7KdhDQGSPhIuVPCSDrJby4abJkS3FfEQ5BxA5hemjvN9xZYC
         f0HQLuHH242uuwmKRoDKbsoz8BP2/4KdsGeCEO+ZpioQLw/PVjVTIUjecxrF5bjUk/dB
         7w2kcnrcWh5gGvoKh4496mkOxZSXxIvRWmgyNsTl4I4yZvTdCn88gL9cDX10EXtimZ+v
         id3WdZR5kBsHOGlzrBfsIkTsqhIWc0mipnLJsf8eszFjO8xdX28RHQPKyA+lWVyCnoww
         d3JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794324667; x=1794929467;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gXjqAYmOZzBpoVOClTeMCf3Fr5RoD9/tZaRkMD38hnw=;
        b=iZ1LjlRu3OxBaCveVpgoMwyM0FFXxhKx2p/OHKKdBPnv8N6LLHoglS5t6P/ILqhhRG
         bBbXcc4SyfrwyelkCyFDQPM27CnxjN7raONeJThMi3FCsVavN3qGAlLA8oedhYjM08i5
         N24KrEwd498z4LDD2lG+MHs4i0llWj/4Vt4ipaVkl8EoIgBdmWPTIcGdgKza0VSgQQej
         C7fgUMl2gXJao+nBfBX6W+Ef6f6PzBVnBJVhISn+fm6yPrry7xjK/itFhvY7CkvPx2d8
         NKXwdbK9bW/Xt6TPSteJ+3J9Q3rIo9pK5F9QZySkry4yTJceYNvVCgdKxNq2AJZLSs8w
         lukQ==
X-Forwarded-Encrypted: i=1; AL+hErHL3ExmbZHB//sFTFR3rqJM+4vWPDUFGn+9urf+6E7EUH8cUmFBPfh5v4N32XvsqbRZ20CjIM0=@vger.kernel.org
X-Gm-Message-State: APuU4Z+oPiqKOXUBKfCqj3szX3dLYaZDyKgu3xjGEBSr/DIfcMeUBhrV
	a1oQ1AbjrYSG7W0TI7Lmc0O3wswoQLZuYNwr+q/qcBjnYrD3B4zuAGpeT8aPe/Aze8TMbfWZ8sf
	0M2WNz1iEC2nnWVsAsOgnWNV5xUX9EaaF9c8zdt7Yl2gb75+RAGpouhsGrg==
X-Gm-Gg: AYBFou2n98Py8KjP6/640YTSfdD03LINHInbRG9+QYW4mCKzIKuw6qWXguvwFYpgMu6
	wRjUkdplAyc8TV5h0Nr1b/1f3GS3Jkq5uAGiZ86llQRVzlo7qy63smTUgJr3VHYslkSkgrrVuTM
	Lb9mfGqdrx9+qtozLW4ktwPraUCq6OGDnKSAbBupt0aYz/0OIS+QhkVL1w3t6n1qcWALZnLInIj
	AyK/NHJKXrIgCX739oJi0cCWAesIQ+xhvkN2y7BcQniy35Dllf3IuQNbD/HrISVAtfEOHcvwlI/
	THKM8dxary2IVtUhcNf3bKEGgBfKHVeyOrP8rmF/3l3ir5g63Cou0kYCO/4/zqRprpewKJQVZYp
	u1GZx2wVowsbvM77wm/raUhftzUrfBvG9WEo=
X-Received: by 2002:a05:600c:811a:b0:4a5:1cf1:b7bd with SMTP id 5b1f17b1804b1-4ba02348d9amr50067715e9.16.1794324667017;
        Tue, 10 Nov 2026 07:31:07 -0800 (PST)
X-Received: by 2002:a05:600c:811a:b0:4a5:1cf1:b7bd with SMTP id 5b1f17b1804b1-4ba02348d9amr50066905e9.16.1794324666429;
        Tue, 10 Nov 2026 07:31:06 -0800 (PST)
Received: from [10.43.3.161] ([213.175.37.14])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ba022ff5c3sm31998605e9.0.2026.11.10.07.31.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Nov 2026 07:31:05 -0800 (PST)
Message-ID: <f85f84fb-6e19-465b-8bd6-4d62998c1f5a@redhat.com>
Date: Tue, 10 Nov 2026 16:31:04 +0100
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 09/10] ice: dpll: update locking comments
Content-Language: en-US
To: Ivan Vecera <ivecera@redhat.com>, netdev@vger.kernel.org
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Jiri Pirko <jiri@resnulli.us>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap
 <rdunlap@infradead.org>, Min Li <min.li@microchip.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Richard Cochran <richardcochran@gmail.com>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
 Grzegorz Nitka <grzegorz.nitka@intel.com>,
 Karol Kolacinski <karol.kolacinski@intel.com>,
 Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
References: <20261106121005.1327603-1-ivecera@redhat.com>
 <20261106121005.1327603-10-ivecera@redhat.com>
From: Petr Oros <poros@redhat.com>
In-Reply-To: <20261106121005.1327603-10-ivecera@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/6/26 1:10 PM, Ivan Vecera wrote:
> Callbacks run under the DPLL core domain locks instead of dpll_lock. Note
> that callbacks of pins of an external DPLL run under the domain of that
> DPLL, so only pf->dplls.lock serializes them with the rest of the driver.
> 
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
> ---
>   drivers/net/ethernet/intel/ice/ice_dpll.c | 4 ++--
>   drivers/net/ethernet/intel/ice/ice_dpll.h | 3 +++
>   2 files changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_dpll.c b/drivers/net/ethernet/intel/ice/ice_dpll.c
> index d6302409a2dacf..07cbd4cf0160ca 100644
> --- a/drivers/net/ethernet/intel/ice/ice_dpll.c
> +++ b/drivers/net/ethernet/intel/ice/ice_dpll.c
> @@ -1178,8 +1178,8 @@ ice_dpll_input_state_get(const struct dpll_pin *pin, void *pin_priv,
>    * peer via dpll netlink learn about the update.
>    *
>    * Context: Called from dpll_pin_ops callbacks after pf->dplls.lock is
> - *          released.  Uses __dpll_pin_change_ntf() because dpll_lock is
> - *          still held by the dpll netlink layer.
> + *          released.  Uses __dpll_pin_change_ntf() because the domain lock
> + *          is still held by the dpll core.
>    */
>   static void ice_dpll_sw_pin_notify_peer(struct ice_dplls *d,
>   					struct ice_dpll_pin *changed)
> diff --git a/drivers/net/ethernet/intel/ice/ice_dpll.h b/drivers/net/ethernet/intel/ice/ice_dpll.h
> index 4ba76e2e2e0b01..39e041a30090d0 100644
> --- a/drivers/net/ethernet/intel/ice/ice_dpll.h
> +++ b/drivers/net/ethernet/intel/ice/ice_dpll.h
> @@ -165,6 +165,9 @@ struct ice_dpll {
>    *     tx_refclks usage map), acquire pf->dplls.lock first, then
>    *     ctrl_pf->dplls.lock. Skip the second acquire when pf == ctrl_pf
>    *     to avoid recursive locking.
> + *   - Callbacks of the SYNCE and TIME_REF pins of an external DPLL run under
> + *     the DPLL core domain lock of that DPLL, not of the TXC and TSPLL DPLLs,
> + *     so only @lock serializes them with the callbacks of these DPLLs.
>    *   - @txclk_notify_rwsem is held for read across
>    *     ice_txclk_update_and_notify(), including the out-of-lock
>    *     dpll_*_change_ntf() calls. ice_dpll_deinit() takes the write side
Reviewed-by: Petr Oros <poros@redhat.com>

