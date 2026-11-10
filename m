Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794313216;
	b=KMO06j3OS3eqAxAIXfwThk/QgWwOjt/62kQf4dzp0aBA+UZmB4VhyFuOhyRic4v8KhkR
	 ytVunnIXYLJSlpJuJgq2kRcfn3lbOBi27NdF0+9xBLd+Cr/3YDIs6mrfhiZFsmsz8yCp7
	 IMMer6+jgM4wN+GWGiqOVYKu95G47hXun8aW8ybj0lzaBR2FVgOSO28c8HjPloza/KGZy
	 /5sQ0LMx4VLHGdDPJsw4OpqnmIFAscrtLfZb3xsF+VZWuGiaedmzxrkwQyOrXEHBAlXcy
	 dlLdO52dZM3E9v9QqSfyD6/1cv3Nyc8GkBdOuQM/mTrB/JMloQP+MJuKQuSzJBPuVfA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794313216;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=kPdufsPBJpaLhkzWQqqT8FSuhylKhYmUXeIW0aMLwqc=;
	b=momhV0U9sH3gokP/qTLgZsEtcBMaSmVaUkFuPyJ4eiQNkpUVxuW9ovQNdElpqfvXafTU
	 wbHIBSfAcFzA/yuCs5LNV4hW5XMTLeFGeHKCfse4BF55Xj0jxOIT3q+7wXbcqgocy8k6k
	 hjpsQO8CZIz8d9du853p6DZRkICMcwmZvTyJMK1Gy5Ec5ZQdWQ7mFXyU7allPXnJlcDvn
	 R3Up+NSO/3RgMpuk/Q02a/BYrpy3PTsuw3ZoVFCBOHzBCSp8l8BUaPesyrhQa+9bgGBfs
	 P9nsr0QUtOiIEaKqUaT9sKk0CSEj30ew9LCPXgHgrpAExgxGErypoJqdBBhpnhwV7AQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=LGkizSni;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=ovaevFci;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25AFB606A31C
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 12:20:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 25AFB606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=LGkizSni;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=ovaevFci
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794313215;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kPdufsPBJpaLhkzWQqqT8FSuhylKhYmUXeIW0aMLwqc=;
	b=LGkizSniNGYF4hqBVCtIB8IV798WGc5n7tl9FrMTCMWuyFJqZdqk706zaCf34QgvrjFrlW
	0tyc/rb0x++w82Ug5QsmQTXDiojsKxaBoGXQ9kYVjpEvkyqA1lyEugZEIVK0m3svATSUgU
	iBMSWTIJrMu9XhY1jJJFdJ/N2U5gjZs=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-644-PI3UEqCdNuS4742ajXbAzA-1; Tue, 10 Nov 2026 07:20:13 -0500
X-MC-Unique: PI3UEqCdNuS4742ajXbAzA-1
X-Mimecast-MFC-AGG-ID: PI3UEqCdNuS4742ajXbAzA_1794313213
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-4916bd6e3baso1637061f8f.0
        for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 04:20:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1794313212; x=1794918012; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kPdufsPBJpaLhkzWQqqT8FSuhylKhYmUXeIW0aMLwqc=;
        b=ovaevFcimn2HnEBjjZ/NGwI9bTwKxnGNmYozXjxjutP/+44svBl3WI0nrxw003GSU5
         QQPmjOgGO8Ot+VFawHXgtbSi+i59M+yI7goxfir4Kk2nysNV91nr8XgtWod6r5IqyTX9
         NeSvpC71yJNnakGxqD6nmm/dbvsL4qGNF5Xyf/9ewEUwTIn4Bs1ImutMRuadkz4pop80
         1HdmENo6P5iHz0VEUoqeYbgce/bBgZJysPJokj5LXIQNYXsIzU28xrucgvCkulJwLZAF
         kxg3osvKjQlY0Z4+xanBxp67BY6br6ReKQs8CVQKIxDA5bGE0VbiSI209tR9eZwnCV3E
         GwNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794313212; x=1794918012;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kPdufsPBJpaLhkzWQqqT8FSuhylKhYmUXeIW0aMLwqc=;
        b=Sp87ON3H+u6WRm+ylnJnbN4Qt8KtThKXRWqv2Vkt4eD54tRAxP7Z10gcWXcwyb10sr
         dNA+C+HdLuIVhsYNifc26iUWDVxWa6GGZLcnhbt3b8Zdvw9x1620HjAgi6jLC+4g4Ym4
         ZiTBJnlyDu0LXJjjhcsHv4GsA1T+87cjAaYQ5n5XyDj0T/sNad/82jReXhRxVwu6rhAO
         aJplQ5AIsQJszSiEDqrikwqgrogQHm4oGM25v5JYSVakJ9C1Dtrw19o+Ruqk3z3cBTv6
         1BRCCNlgt59LYuJNQOTuXIgnY+t2kYwmtG0pu+3EMFmqRsSYV0JHcfhuDN6BUAmWAHjB
         MbyQ==
X-Forwarded-Encrypted: i=1; AL+hErED03aIELCtCPX81q8vqaeviabvFqy3pelw/SOTkO06/AEiUHCeeUpnWo93x1idgJ0pTB/i8Ic=@vger.kernel.org
X-Gm-Message-State: APuU4Z9HCOobfFti3jPAEu8iF70UtODz15FaHUEEgVNF0dbrnSYL2578
	t0qyhcMFk8DDQh6Bb09FM3O2nPmLY92V2rRCEJGX/qQ5rHIexoUXt5k3yT32qeZvfNXoLtnybnw
	lJVTSnZCt3Osqu60k5D4a6fMBt04JS3mMUGdq/E67emsScGtzVVGFo6vgHw==
X-Gm-Gg: AYBFou2jc39xJ8FJfcXb6guLK3yOuKWTMZ0azqdnv58iHau1P5qA1DSGxPIV55gfkj3
	EGn2eSry1237hqKOVqIVPR4X4DrjF+W7t/aQbcM1aCYFi0XkZ2RT5N6UlbVwPN7rp+exD/jtDGy
	ig9e1zBqAsB0GNiDdQMiJ7KQK+23ZrwtlfthU1T5/ifal3uWPPkV/wYaFKHetKox4rqL+M0q7rk
	8tn0QVNiOWKm3kyiQuXYFXxSH6mSdA392zcPS7mv3/Q6A/W1E+n05YkIYXpG/1nidKxaSAiWUlQ
	FK2V/UHdv8omjRR+hKzwi0InDFUbe3a9Vnbwk+yhEDrGvXZciqqytMt6K7fzdXBLEGFcCluGQ6w
	ehEW09CS4D6LljGxIIPsBpx4VQyI2Kd65Os0=
X-Received: by 2002:a05:600c:1c0c:b0:4a2:150f:1607 with SMTP id 5b1f17b1804b1-4ba0233e877mr44341105e9.13.1794313212300;
        Tue, 10 Nov 2026 04:20:12 -0800 (PST)
X-Received: by 2002:a05:600c:1c0c:b0:4a2:150f:1607 with SMTP id 5b1f17b1804b1-4ba0233e877mr44340455e9.13.1794313211833;
        Tue, 10 Nov 2026 04:20:11 -0800 (PST)
Received: from [10.43.3.161] ([213.175.37.14])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49835c377fdsm3961339f8f.21.2026.11.10.04.20.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Nov 2026 04:20:11 -0800 (PST)
Message-ID: <a873e0f1-ead6-49da-93af-d2c2d79c9741@redhat.com>
Date: Tue, 10 Nov 2026 13:20:09 +0100
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
Subject: Re: [PATCH net-next 01/10] ice: dpll: notify TSPLL lock status from
 the periodic work only
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
 <20261106121005.1327603-2-ivecera@redhat.com>
Content-Language: en-US
From: Petr Oros <poros@redhat.com>
In-Reply-To: <20261106121005.1327603-2-ivecera@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/6/26 1:09 PM, Ivan Vecera wrote:
> ice_dpll_tspll_state_on_dpll_set() notifies the TSPLL device from a
> callback of the TIME_REF pin. This pin belongs to an external DPLL and the
> DPLL core is going to run its callbacks under a lock of the pin's owner,
> which does not cover the TSPLL device.
> 
> Only update dpll_state in the callback, so a device get reports the new
> state right away, and leave prev_dpll_state to
> ice_dpll_periodic_work_e825(), which then sends the notification. It now
> arrives up to 500 ms later and after the reply to the request.
> 
> Refresh dpll_state on every run of the work, as the state written by the
> callback can be transient and the lock status can return to
> prev_dpll_state before the next run. No notification is sent in this case.
> 
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
> ---
>   drivers/net/ethernet/intel/ice/ice_dpll.c | 14 +++++---------
>   1 file changed, 5 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_dpll.c b/drivers/net/ethernet/intel/ice/ice_dpll.c
> index ade1fb3dd06743..bdbcf7af296eb4 100644
> --- a/drivers/net/ethernet/intel/ice/ice_dpll.c
> +++ b/drivers/net/ethernet/intel/ice/ice_dpll.c
> @@ -2914,7 +2914,6 @@ ice_dpll_tspll_state_on_dpll_set(const struct dpll_pin *pin, void *pin_priv,
>   	struct ice_dpll_pin *p = pin_priv;
>   	struct ice_pf *pf = p->pf;
>   	enum ice_clk_src clk_src;
> -	bool changed = false;
>   	struct ice_dpll *tp;
>   	int ret;
>   
> @@ -2947,15 +2946,12 @@ ice_dpll_tspll_state_on_dpll_set(const struct dpll_pin *pin, void *pin_priv,
>   		WRITE_ONCE(pf->ptp.tspll_locked,
>   			   new_state == DPLL_LOCK_STATUS_LOCKED);
>   
> -		if (tp->prev_dpll_state != new_state) {
> -			tp->dpll_state = new_state;
> -			tp->prev_dpll_state = new_state;
> -			changed = true;
> -		}
> +		/* ice_dpll_periodic_work_e825() compares the state with
> +		 * prev_dpll_state and sends the notification.
> +		 */
> +		tp->dpll_state = new_state;
>   	}
>   	mutex_unlock(&pf->dplls.lock);
> -	if (changed)
> -		__dpll_device_change_ntf(tp->dpll);
>   	/* TSPLL reconfiguration may complete before lock is reacquired.
>   	 * PTP periodic monitoring tracks and restores the final lock state.
>   	 */
> @@ -3372,8 +3368,8 @@ static void ice_dpll_periodic_work_e825(struct ice_pf *pf)
>   	mutex_lock(&pf->dplls.lock);
>   	new_state = ice_dpll_tspll_lock_status_get(pf, true);
>   
> +	tp->dpll_state = new_state;
>   	if (tp->prev_dpll_state != new_state) {
> -		tp->dpll_state = new_state;
>   		tp->prev_dpll_state = new_state;
>   		changed = true;
>   	}

Reviewed-by: Petr Oros <poros@redhat.com>

