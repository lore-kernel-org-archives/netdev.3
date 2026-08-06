Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E1F938757B
	for <netdev@vger.kernel.org>; Thu,  6 Aug 2026 09:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786009289; cv=none; b=njm1nhQHWOlT2u3i5VN/m7zy5SUkWRhfifqhqWYN4ET/ydOqwwAaxx0aso3GmxJdJwPjJoMH0KE9NHyyNOFf1bPycf8SpUQvgpreFuZ2INHmOi3an6oVtRuyQPWgP51NQ7NJsB3TIl6OeJde7PM/C/qj2kn1whwsY+Qwlom99Wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786009289; c=relaxed/simple;
	bh=uJ1y5/CS5v2Ay70tM26cPgrpmyvQZ+ahXvKr9LMURok=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aYke5d7XKzKuzv4buvzj2oKAGNmkFlH//naEdWRqFJ1LG3cTujiDDLw4ol+DyfAZIT+c1eJRr7mplVdEryPPzW7dqXMCoM6raAv0N78pk2Ec74VDsiH74W3AVzqfXUOIwH1C1OCGMkqqZJ3NkTSdCQvG/8JBtUy9Bm8RpI5l3Zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ap/5rPwF; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=X4DoWIV1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ap/5rPwF";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="X4DoWIV1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786009286;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/pXBA5d8ovqzrxLyC73uQmUReb3p2yg2U+QZG9FKHcg=;
	b=Ap/5rPwF6V0FUcp0cWzw+MHg0bhrW6eJu8R6KGTPRfSo/Erk6E77gnmIOn0W57VJC8re3Y
	1ZlKJmlIbdtJuo3s8gm/O6ZpMC6m7p+t/pJcpUH0EMFwbSqH5dQX9p41Xo+CaFfzlZ9I21
	3znKfSD1DL74H4b8chJGddsvsyoyPUc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-563-9FZEMcC5NxuWs6nCI8eboA-1; Thu, 06 Aug 2026 05:41:23 -0400
X-MC-Unique: 9FZEMcC5NxuWs6nCI8eboA-1
X-Mimecast-MFC-AGG-ID: 9FZEMcC5NxuWs6nCI8eboA_1786009282
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-47f810c8aebso1121951f8f.2
        for <netdev@vger.kernel.org>; Thu, 06 Aug 2026 02:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1786009282; x=1786614082; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/pXBA5d8ovqzrxLyC73uQmUReb3p2yg2U+QZG9FKHcg=;
        b=X4DoWIV1CrZ/LAEx/JbFaX4axZXkj+sHYmXopEZctAi+PZiGoLknNfyBeA4Gylr8l8
         kfuFiXEcCn4G30Q+sKB7XVrg/Gbqu79Qo4BAaHRywnJWYWkFaKD5cPQOom+ZChIgdiLF
         bhyRW+1Lcouj3ZxT9AlR6AzRcGym/is0YOSIzfjq43UE/miThs6PSXMZfrc7p8CYxbrW
         bY+P+nZvyb5sQSbeGhTwmnUHSArWQs37wPwEpHTpX0NnKnYLf6QEN1QLtYhKqool2WPl
         xK2GfQIjx+MD+yZq1jX+6zyWnQmAr6oGu7DQVzRTlkLJldKU6wrQWFl4WU1MVhWNkHgc
         6qKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786009282; x=1786614082;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/pXBA5d8ovqzrxLyC73uQmUReb3p2yg2U+QZG9FKHcg=;
        b=nABtcIKiDKNUXjh/p1J/P0kB6nBpfqbBqPqfA4eNX0cPzNpVEPqqkwzCouOd+P9M4t
         qitcRG0Ec5s57W6+YG/xJg/K1dxlwkva52TMqX9O0ky79VOTN3cFsdjTsoVujXAEt8Tk
         hAoo4uFCy/l3Ac5eiQUAJC3HcF9C7nbkiOP5hQpaMZxxJHpRmCHGn+x74UVt9N4alnHt
         AyO3xvDY6CvSd7tncGqudmvKkBQDN93LdY97QhJqb5wMkGRL3rhNEEEugFq92L/ROzfx
         XxRz9UPH/JXD3c9J22eNurLkTRmtrb2c/Rt1QGnBVaJA4uSw2O/JPDb1hsjMEJey1LpD
         cS+g==
X-Forwarded-Encrypted: i=1; AHgh+RrbGxdw+s2swf3NORmOosldsHs7FqfEB5OIOgx9WR/827WFIkwNr7nUUcKLwxGteu/6EgKNlp0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFoJXdYB0g8WZYetiZzvZ+W2fBp1wPbA6QpKa+Zj+P9WC0d2Q9
	qgz5ihWm3ZQxzVbkyzyDpRD90tXQ5Lwt2YLhJrIHzRs6XHanyqYjQ+QobMHhMeQKOKVe1DdVDGk
	8lDoj2edao5ubol76hP2LBX7XrXvBLdZITZgq0zhl86R+FptLzrNgrbtrvg==
X-Gm-Gg: AR+sD11tEpUmyfG0x7fIU4CUMkhoQm5VY51WDYJ7n1Z8RacWzalqmWDXkgayH37IDeE
	UEW/aqZ+oSEf7HLuF1cUJFX75gR0LMocQN326dLuExz2K5cukHgm04/cx8w3/Ej6JPzclTAqPlj
	IqN+4JF6FEDhuHbXOoN6qDyIK6J6L5Bo6OK1MYg6ldp/2cvUD1m1dXCq1YwEoED1gRrQWk+zca/
	7Qh8BtBe9jdiZWVyJrRG5OXKVHddStrTSby+clQisBclOdsuhb+3i3Dnq4EaBc9EC67Jh1+TSCa
	45IcKQMTwhQmrU+lqejXOQ76rA53BsHVfTn9Kw9b7pIQQoyPA4vBsuEvHrkAjUaIQ3wE4ImDWyd
	MvfcU2P+duIW69ZbQ66x+g+JgTW6Q9eK0S4XRxeFozGkZugqbJEswgkxr09KNscFu9HwQjJuxgW
	E=
X-Received: by 2002:adf:d006:0:b0:47f:9171:bca2 with SMTP id ffacd0b85a97d-47fec62a14amr17245703f8f.27.1786009281877;
        Thu, 06 Aug 2026 02:41:21 -0700 (PDT)
X-Received: by 2002:adf:d006:0:b0:47f:9171:bca2 with SMTP id ffacd0b85a97d-47fec62a14amr17245608f8f.27.1786009281277;
        Thu, 06 Aug 2026 02:41:21 -0700 (PDT)
Received: from [192.168.188.103] (ip239-44-231-195.pool-bba.aruba.it. [195.231.44.239])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47ff79a7258sm4789418f8f.3.2026.08.06.02.41.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Aug 2026 02:41:20 -0700 (PDT)
Message-ID: <8b498be8-8b5b-49b0-b20b-71ca8cc277cf@redhat.com>
Date: Thu, 6 Aug 2026 11:41:19 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 2/2] dpll: use pin owner's dpll ref for
 pin-level attribute setting
To: Ivan Vecera <ivecera@redhat.com>, netdev@vger.kernel.org
Cc: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Jakub Kicinski <kuba@kernel.org>, Jiri Pirko <jiri@resnulli.us>,
 Petr Oros <poros@redhat.com>, Prathosh Satish
 <Prathosh.Satish@microchip.com>, Richard Cochran <richardcochran@gmail.com>,
 Shuah Khan <skhan@linuxfoundation.org>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>, linux-kernel@vger.kernel.org
References: <20260803120245.56046-1-ivecera@redhat.com>
 <20260803120245.56046-3-ivecera@redhat.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260803120245.56046-3-ivecera@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 8/3/26 2:02 PM, Ivan Vecera wrote:
> Pin-level attributes (frequency, phase adjust, embedded sync, reference
> sync) are properties of the pin itself, not of a particular DPLL device.
> The get callbacks already use only the pin owner's DPLL reference
> (via dpll_pin_own_dpll_ref_first()), but the set callbacks iterate over
> all registered DPLL references and invoke the set operation on each one.
> 
> This is redundant because a pin is a single physical entity — setting
> its frequency or phase adjust once through the owner's ops is sufficient.
> Calling set on every registered DPLL just results in duplicate HW writes
> for drivers that share a pin across multiple DPLL devices (e.g. ice
> registers each input pin with both the EEC and PPS DPLL, zl3073x
> registers input pins with every DPLL channel).
> 
> Simplify dpll_pin_freq_set(), dpll_pin_esync_set(),
> dpll_pin_ref_sync_state_set() and dpll_pin_phase_adj_set() to call the
> set callback only through the owner's DPLL reference, matching the
> existing get-side behavior. This removes the xa_for_each iteration
> loops, the now-unnecessary rollback logic, and several local variables.
> 
> The -EOPNOTSUPP validation loop, which checked ops support across all
> owner-matching references, is replaced with a direct check on the
> single owner reference returned by dpll_pin_own_dpll_ref_first().
> 
> The documentation in dpll.rst is updated to reflect that pin-level
> attributes are set through the pin owner's dpll reference only.
> 
> No existing driver is affected:
>   - ptp_ocp and mlx5 register each pin with a single DPLL.
>   - ice registers input pins with two DPLLs (EEC and PPS) using
>     identical ops and pin_priv; the set callbacks address the HW by
>     pin index, not by DPLL, so the second call was a no-op.
>   - zl3073x registers input pins with every DPLL channel; the set
>     callbacks address HW by pin/ref ID regardless of DPLL. The
>     ref_sync_set callback was the only one with per-channel behavior,
>     addressed by the preceding patch.
> 
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
> ---
>  Documentation/driver-api/dpll.rst |  10 +-
>  drivers/dpll/dpll_netlink.c       | 213 +++++++-----------------------
>  2 files changed, 55 insertions(+), 168 deletions(-)
> 
> diff --git a/Documentation/driver-api/dpll.rst b/Documentation/driver-api/dpll.rst
> index f83150917814e2..6fb50e53475c09 100644
> --- a/Documentation/driver-api/dpll.rst
> +++ b/Documentation/driver-api/dpll.rst
> @@ -116,8 +116,8 @@ Shared pins
>  A single pin object can be attached to multiple dpll devices.
>  Then there are two groups of configuration knobs:
>  
> -1) Set on a pin - the configuration affects all dpll devices pin is
> -   registered to (i.e., ``DPLL_A_PIN_FREQUENCY``),
> +1) Set on a pin - the configuration is performed through the pin owner's
> +   dpll reference only (i.e., ``DPLL_A_PIN_FREQUENCY``),

I find the new text confusing; it seems to me that the pin configuration
now affects a single DPLL.

Sashiko nipa has several comments, please have a look:

https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260803120245.56046-1-ivecera%40redhat.com

and also please be aware of net-next commit c82ff94592fb.

/P

/P

