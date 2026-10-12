Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27C0249E5FB
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 16:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791822459; cv=none; b=BdSowuXGA9mVi9tA7E74SKL7mTS51G6Bh2VyAuBjzDFxLphQvHxYXloEfDmDsjo1t18G2N1mdQUqIGE2SbSsow7xYRuY1xpYeXeoQv+5fYrZblV6DIySObkIIA4jZHS8euZ/IksBtiz7NePoDRH1HwpNqawLtKZbKR6fhLtxnb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791822459; c=relaxed/simple;
	bh=zkr7WBLDtC/RyKdHb7CW1HYyZlDD08zJ7+NVgznsRRc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ktYDV6Q4uGUKj89WDqt0R0c10YBYi2tB3/zu9Mc3fuC2pNwJdR7sd90fW/KSJGgYsw2qVjLDOH8Ik49VxtzAv5rFFQu9bxnSVzD3sd51fjJWcqKnoF1HW62UT/sLd4oQour5xQMbVxwbAfGf5xmsqk453f7HiMqpwqlq9vnsCBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YHjqDrFq; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YHjqDrFq"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-48b02b1b4cfso2646720f8f.0
        for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 09:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791822456; x=1792427256; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TDpwaJ1oRpLE3raEQoNefoSEla8kJ3ERyibh0Mx62mQ=;
        b=YHjqDrFqSGu0z6XIUgO+ztW/RrPOJpNK9Nx0iErM2UyWW2ya4uPc8aP/KH8nRYNgOR
         scXkREAWp8KA15DW8mdEDz568GRm//RzX3lSXiY8XGYh8s4lgwfSjKwAJ05WjqmbJifG
         tG2LOmEU2dagwXSSSF6hV4Lp/UHrj2PuGqvddV9H4GL1gnolHrp/T280vSs3U8KcKlPi
         mP3yP7cr7Rj0YOrTBIcdBD1CYu3u0phQmaJykb0dDHFgURNQ11WElhug9cUkX3lrD6+T
         QlX02IMv1YRngaHRH64aIGEuh0sYB1m4STdwE+wZJdTN7Q2TJRa1lRD2NMuy3WDvdzfR
         BF+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791822456; x=1792427256;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TDpwaJ1oRpLE3raEQoNefoSEla8kJ3ERyibh0Mx62mQ=;
        b=RO0Wpcp7DD8GP7IG9xKvrQTZihcv77GIW7kZNQfBHzMMuJTNoonAWeml5e80Y40pdS
         Jl5amr/+VcOUE8MyaKJ1NZLd4TOwqubSgRuMDibry2cCVIc5sprPtMwOw9JEfQIbJz/O
         /A18IURNle4AC2pRgD/zyb4Tml5T0yV8uUFyRC+TR789IgpuepgrleRkwmwdhe0AYVIk
         gbGzZgFVlYHkgY1jU+aHJBBGj5O/B/zaNJif1KgMG1h/LhJIUUIObejvQi3ug3sK0qF0
         Z4GkipxKQgkmdU740PHW+1BXp3mnU3Rdhq1DoB5Zot52HVk3ddw2SVM50Ib8MUUi0d4S
         uoSw==
X-Gm-Message-State: AFq9FYLieghC0ua2wCj5Lk5ERjivz2sdrBE7QW9UPXNF5qgHQhbMNCWM
	86G5WnPrulVArN/sXdXuovoXvPjK8xsm+KXw4Tx85ZpAGXj01E1ieL8k
X-Gm-Gg: AYBFou0fQVmTCeYYwl/Qa6FwKCCZ0hIdEdr4xYdBCKpWBLqsFW4Ugxbnlj3FUtDKu5o
	RoY1rLgNFbrRh8wp+0GKJJgduryJDRVcbjYdFBePd2Z8LVna44umDT5WwXx549OFL8Z6eIdUoV+
	jb731KDOvH/Gz2K3S4w09pvInuRwTYeLof/rdeXuP1eSjD9OVJn5qsdvWT3Ay9tg4G6tlM8/qj2
	x1SRpu7NHUipzuAztyLRZZ8BguVhRHHlnQRU3+MlQBpKuG5SP/fpuekFlEYERPyyTZmLLRz2NGT
	IV/Dvz4X1XRoOG2JWBYx8hI1GHz8F1lsoUsJE4tiuV46hedokBr+Isb5RMuT57wKyAU02yz6/ag
	o5C6T7DNg4ssPCHbjwcfSisOGTHZu+yTydI2SeIKtFnVBI6DdD7QeiO3Jm0IPdssenA4BKPa1Cw
	mVoVAEaBsXLTVQ+o/iPAg4q9EQ4dhBBFp6RDTooHHUzmzcuOjD4N9ugwGK/jQITiapVesIMswMc
	midWKk0/bjcedy3s2t0w0Oa1/NJ3d/V6y+XxHqwrnjs8OilZkZrjD/UFR57tyM+WFQMWO86JM4E
	m2yWVb9nzNeJ4nyZgVc9PdSWBtFAJ18XrNZm6SuXORjcDs4=
X-Received: by 2002:a05:600c:16ca:b0:4a1:877b:d4e0 with SMTP id 5b1f17b1804b1-4a18dcc911fmr134708325e9.12.1791822456134;
        Mon, 12 Oct 2026 09:27:36 -0700 (PDT)
Received: from ?IPV6:2003:ea:8f2a:fd00:f5c8:7592:9084:dba1? (p200300ea8f2afd00f5c875929084dba1.dip0.t-ipconnect.de. [2003:ea:8f2a:fd00:f5c8:7592:9084:dba1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48de0bc506asm260781f8f.47.2026.10.12.09.27.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Oct 2026 09:27:35 -0700 (PDT)
Message-ID: <cb3a1207-53bd-4488-a1fd-88b1f61ff0a8@gmail.com>
Date: Mon, 12 Oct 2026 18:27:32 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] r8169: allow Giga Lite fallback on RTL8168EP
To: Hee-Suk Kim <hskim@dilluti0n.com>, Daniel Golle <daniel@makrotopia.org>,
 Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, javen <javen_xu@realsil.com.cn>,
 nic_swsd@realtek.com, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org
References: <20261010135356.85454-1-hskim@dilluti0n.com>
 <dbdd5abd-f1b1-443c-adc3-6ecdc95f4854@gmail.com>
 <4435b286-1638-464a-821c-f486b647c9f7@lunn.ch>
 <aszgerrI8yoLTaX0@makrotopia.org> <874ierc6nb.fsf@gmail.com>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
In-Reply-To: <874ierc6nb.fsf@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12.10.2026 16:53, Hee-Suk Kim wrote:
> Daniel Golle <daniel@makrotopia.org> writes:
> 
>> On Mon, Oct 12, 2026 at 02:46:27PM +0200, Andrew Lunn wrote:
>>> Please add ETHTOOL_LINK_MODE_500baseT2_Full. Make the PHY report this
>>> link mode in it features, add the speed, allow it to be negotiated,
>>> reported in ethtool etc.
> 
> Will do in v2.
> 
>> While at it also consider ETHTOOL_LINK_MODE_1000baseT2_Full which is
>> supported as "2.5G Lite" by the RTL8221/RTL8226 2.5G PHY family.
> 
> Happy to add it as well, but I'd need to know what PHYSR reports for a
> 2.5G Lite link on those PHYs, as I can't test it myself. Do you happen
> to know?
> 
Also the needed register configuration may be different. Would be helpful to get advise
from Javen/Realtek on:
- Which lite modes exist?
- Which chip versions support which lite modes?
- What is the needed configuration per lite mode (according to vendor drivers the config may
  be different per advertised speeds)

I can't tell as I have no access to Realtek documentation.

> Thanks,
> hsk

