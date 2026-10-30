Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793367973;
	b=TRuWUnLQ0qkwobPV3iEJ3ADh1twV2glPNgJJFsP+GsOsXbCKdG0FDa5SgfDqcAMcEdMf
	 rfMJqhR2UIoZjXVBezFV5XxuvIwSSxmOBmuqj+gxE5F+0Ye1aPjwTcaIYJjmFfdVIkniq
	 IeWrE2L+oo8mW542K4TMPNrFTgMI+fLX3IhRsJBnFZcC7p3FfLMKuBbi70tpjpRSl4j5u
	 HUgtUO45MTDxlZxJq5iCUXo2fZ4sJBKoDaqZfzUG7NYkOCS7alzNZe3oH9JVjzYxegxA1
	 NdRJTJeAPm0KQd0l9O5phJL3w0z90iF0y38ghH1SiCaaCk6huIvGfrJYiWw/c9cfUIA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793367973;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=Cel0vcm4G5w81qs6p/3zOaRkogZgkiMaq/fEg3zUQoI=;
	b=ez9hjdpQ89Gm4rUjDMqk7mN8+++lHX4ypSiZMfeg+SuvDBOd+H3SANEKIUIvxd+YuVTp
	 TV5f5wLZTanlcvFoXRYyyBStVv8+egekzDfb37vCfH4q95lWXZqWBe50330SM5GuevS23
	 Nvaao1R++fXDSDkrD8+ATXfanOzGG0jw0+TZLJr+B7C8ICzbO8hp5wPetcJuKz60k+vKH
	 jjkvJ4nSbxJAg4gTWv2o7zIqM7FdZGRQ+dFtIcDEmWFwM8SqtjNEOKKzpRjVFgk/6rIri
	 y+xV4NKTFXE7rzV0bbbFNnmj/+QK92IrIbm9opWhBzyXLFMW8xWT7Mf33toU0XqFiJg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ieee.org;
	spf=pass smtp.mailfrom=ieee.org;
	dkim=pass header.d=ieee.org header.i=@ieee.org header.a=rsa-sha256 header.s=google header.b=MHCzlPUZ;
	arc=none smtp.remote-ip=209.85.167.171
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8163E606A31C
	for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 13:46:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8163E606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ieee.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ieee.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=ieee.org header.i=@ieee.org header.a=rsa-sha256 header.s=google header.b=MHCzlPUZ
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-4af173320f9so584038b6e.2
        for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 06:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google; t=1793367971; x=1793972771; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Cel0vcm4G5w81qs6p/3zOaRkogZgkiMaq/fEg3zUQoI=;
        b=MHCzlPUZKMnE2kNo9yoyOWyk5iazVdyGZcGd3KBZgWLavn2s/MGurSTnlnGWrQcNlG
         Y4sRWrGUcDXFVzUpwSMONQl4Vvs8Jlm/MTkPIxqmO3Gw4v3nqb5eZnERYCNZ8TeSG9yQ
         lnRadBi21wkXJaAEkA/aq62Uy9tv+sDun8I24=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793367971; x=1793972771;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Cel0vcm4G5w81qs6p/3zOaRkogZgkiMaq/fEg3zUQoI=;
        b=pFkFjS7hMkPyu5h1Rn8SuYqJXlusFTZJ+z/0z53woZRuQ00q/XxPPygxarfNXdxoi9
         ZnUDIn+Lbr2uneaFJdZkMDX9UGcMLImxJjhguj0dmODJPbYmCfCl4HpDpMgbaTFcuxtK
         M4fjgnbU/GGp1EJcndmOGGKeRu8VNjogYjGwqaWyoGql7lxpge+9yloulFQ2hMIUfCbE
         FoHpjRQz5PE8crRB3i3WLyGM+KYaf73m+W2aYACdCLKKp5DM8YFy8wVK587xHAZpN46b
         okv9tHQs7mlG1FFGFLwmJK8RgX6orh5oC1u+QTYm+w6J55JpGgaJq0yvhwdfBLnqym/N
         Nrhg==
X-Forwarded-Encrypted: i=1; AKwUvBy620alIMyYFsfkatajJkwmpaKYtoW0sFsO7HUGWch9SKoxtWWLsb3tlnO3+GnjNQ+2Amxs6yg=@vger.kernel.org
X-Gm-Message-State: AFq9FYKRrj6OmLr5xoJyjXkjP5bvU1pEHUervBNAwa//ERhTVR5UhlqO
	A/mNNDANR9BjDHf63l6il3Qz0XCt6qWBBLQAsO6MClnA4hAnjpadVC5VIjWyzOa+Gg==
X-Gm-Gg: AYBFou0JbnM+B340eG3saqb8e1cChNY3s11b2JxDOaDga+HZH3Atjs08Gxg7nT/sUe8
	/pYRUGRlFmoND16nG5WOP4epGZxip/ZbAts7ohmGe1luW6R9grMiD4aEoL8UlPlQ3lSPFZoMxj9
	YmgeGAyCW8WArqRu7gfbT+a7gBIZoKKLrMB7p8mRHNfREaWf8MMZScmw8bSL4EC6jsBNqFsxynA
	zav0Dzsj20A7vzxyBKTt2e/taaxUuZvyriHP08aa5Z23+zYtNSy031l4raW5kj34NLiI3/IsjVO
	DLmkC/lp1dkwy51ESHnsUNO8lyt7cP6AvL6QyxTcNTHIOoUwRQFZVUv4N13PMhLZnolxGRIDy65
	YoMk1QoEnK4UG4c4HOroyN8eQ10FbzvQocWiUjPpOJ590WfIQ1ngl6U9DE1zSeBo9cqZAZHYAjT
	wWmoAUjZyWetpK6/T1ImOOS6pxT4/0Foi6TYaiYCmo+SLFqBL4tS1f89jx7hiHb9WP+NgXt8Ps+
	CIk18JwkUtfUKq4CNAnfbiPivAI+z1fEuPHBrearlAHvKBNnv+evPxrKhQnN+kWPtu+TaXz9VQD
	RcULrdagqQl1qg4OVBuKa/MZ
X-Received: by 2002:a05:6808:151f:b0:4c3:6d56:77c2 with SMTP id 5614622812f47-5640de7e3a9mr1613306b6e.41.1793367971178;
        Fri, 30 Oct 2026 06:46:11 -0700 (PDT)
Received: from [172.22.22.28] ([73.62.185.64])
        by smtp.googlemail.com with ESMTPSA id 5614622812f47-5640fdcef5asm1492922b6e.9.2026.10.30.06.46.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Oct 2026 06:46:10 -0700 (PDT)
Message-ID: <9207a52e-2d42-4e10-b777-2988e84d7dbe@ieee.org>
Date: Fri, 30 Oct 2026 08:46:07 -0500
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
Subject: Re: [PATCH 1/1] PM: runtime: change stub pm_runtime_get_if_active()
 return 1 when !CONFIG_PM
To: Sakari Ailus <sakari.ailus@linux.intel.com>, Frank.Li@oss.nxp.com
Cc: Frank Li <Frank.Li@nxp.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>,
 Karol Wachowski <karol.wachowski@linux.intel.com>,
 Oded Gabbay <ogabbay@kernel.org>, Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, Tvrtko Ursulin
 <tursulin@ursulin.net>, Matthew Brost <matthew.brost@intel.com>,
 Thomas Hellstrom <thomas.hellstrom@linux.intel.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Alex Elder <elder@kernel.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Guenter Roeck <linux@roeck-us.net>, Guan-Yu Lin <guanyulin@google.com>,
 Mathias Nyman <mathias.nyman@linux.intel.com>, linux-pm@vger.kernel.org,
 linux-usb@vger.kernel.org, dri-devel@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 linux-hwmon@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux.dev, linux-arm-msm@vger.kernel.org,
 linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
 netdev@vger.kernel.org, imx@lists.linux.dev, Rob Herring <robh@kernel.org>
References: <20261029163044.3062958-1-Frank.Li@oss.nxp.com>
 <auRb_r8ZSSU-eHZA@kekkonen.localdomain>
Content-Language: en-US
From: Alex Elder <elder@ieee.org>
In-Reply-To: <auRb_r8ZSSU-eHZA@kekkonen.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/30/26 3:57 AM, Sakari Ailus wrote:
> Hi Frank,
> 
> Thanks for the patch.
> 
> On Thu, Oct 29, 2026 at 12:30:37PM -0400, Frank.Li@oss.nxp.com wrote:
>> From: Frank Li <Frank.Li@nxp.com>
>>
>> When CONFIG_PM is not enabled, all devices runtime PM state should be
>> treated as active.
>>
>> __pm_runtime_resume() returns 1 (called by pm_runtime_get()).
>> pm_runtime_get_if_active() is the try-and-get version of pm_runtime_get().
>> stub pm_runtime_active() also returns true. So pm_runtime_get_if_active()
>> should return the same value as the stub pm_runtime_get(), which is 1.
> 
> Shouldn't the same change be done to pm_runtime_get_if_in_use()? It's
> otherwise the same, except that it requires also the use count to be
> non-zero.
I think "yes."

I think the logic for !CONFIG_PM should basically pretend runtime
PM is enabled for all devices, and they're all ACTIVE and effectively
in use.

That implies:
- disable_depth == 0, so usage accounting would (if enabled) be done
- runtime_status == RPM_ACTIVE (power is on, no delay)
- usage_count > 0
- runtime_error == 0
- Maybe ignore_children is false?

This might not be complete (and could be wrong!).

Some of the other dev_pm_info flags could probably be assumed false,
because they represent states in transition between ACTIVE and other
states.

					-Alex
