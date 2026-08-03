Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A9054137BC
	for <netdev@vger.kernel.org>; Mon,  3 Aug 2026 14:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785768014; cv=none; b=H9y5jaWLACYp74zSHa+8LLG7qq46GlEGEdCicVHDKpihgODTC/Ag97U7Rbo0zqi0cx348mBM7KAkOWkNEfMiVFMtT1gHB7g5r0+E41xFCEi8JJhyEHujrdUsYez+0lhlL9uAIuQXiTkSkK/cX+0Qnj6ucxbzpWAqovV4EyhXp+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785768014; c=relaxed/simple;
	bh=yRItg3rDqLQ6YBYhIhF8iPn7fPEpjv7eS82GGOPWVH0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qzkTNuvvm/FeXNoWRaVclcQCWv0HaSbqpmorrEbfW1MpE5vjMLksAJyu2/299ngw+C44d93dnwMZXXeSf0Ko44PssE+Wd6DZDZvM5jSHrEYskP222KD2Mjg33c4Mc70LwzpgQrmgCOg9EZBt6t31tuctQ8VZ0T40unGVexKMsh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Vd59kCVy; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=GaCPVV2C; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vd59kCVy";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="GaCPVV2C"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785768012;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VmoRzRSGaYrgmLSXQHd8nxnywAiGDAxo7QcVjOS8Dtk=;
	b=Vd59kCVyh9AMk2fWhFJQPRZ6jnzTsVfI4pUeRdrPUxZbcl6VeSpKZIz+gOW6InDIcfL/5p
	laolMSpCF3+19kMI6Qaym32IraMqW2TcaKmQUPYR3PsvyDT5RAWGS3FvtVtubgFHdA+KVT
	+LSjid9lo38/JCnYWsLzI9ndt4XfsoM=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-74-xNloLJWmNhGFlzd5uY6wPw-1; Mon, 03 Aug 2026 10:40:05 -0400
X-MC-Unique: xNloLJWmNhGFlzd5uY6wPw-1
X-Mimecast-MFC-AGG-ID: xNloLJWmNhGFlzd5uY6wPw_1785768005
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-81ebbbd60cbso52607957b3.1
        for <netdev@vger.kernel.org>; Mon, 03 Aug 2026 07:40:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1785768005; x=1786372805; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:content-type
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=VmoRzRSGaYrgmLSXQHd8nxnywAiGDAxo7QcVjOS8Dtk=;
        b=GaCPVV2C6EiEsAPf32UL1SA6BBsZ7S8GnmY3MeGjMgGxUI/AJ/RyV/kTFgxVVa4H+Q
         Vc+nr7dgrPD2C5BNy/hCHzb+ReMBg+ecv14vBNi7QsWbWpA9dpzv+xoHJx+p6lvACXpi
         EMF5f8jLBmzhBQEvpdRdag7uwy1mHxMpAT4sUx/SVSCqdTV9FrEcYWpp2QO2VhhFqSEg
         G6TXsbOL7uKsWvWA18oeMzT6kWy8TAnm5VCufww1E0oVl1GaAHhZhxB8hPWZb2LttA5b
         BIRnWWVJbxRyQvZHqIM9XwNrxhlhfcw7y1AWl1Y2xpu87Y4zfby/pre2qoZQa6FJpk4Y
         gW9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785768005; x=1786372805;
        h=user-agent:in-reply-to:content-disposition:content-type
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VmoRzRSGaYrgmLSXQHd8nxnywAiGDAxo7QcVjOS8Dtk=;
        b=Gyd7CF+kkzYpBIHF0IHWRUzKLS1l0G8dGlK3T9OmC+t8BIQ1bS1lQ7yT8dSsrOoejz
         KFhzIgWjzAG1b8LTQ/bWfTtiqhRHZ/Nrc1TJnKRn18uQPScvx0Rava1XvhQapph5ulkP
         A6FFh6qhdikuSCBoJnr8se/fS5jSo3DN6JOR1/R3HtPSVzJXhoREsQCP/3No3GMIl+rc
         F/nd1qaNebLBaEQHP46u3uasFki21xstc+UCP13DUUdmNUhB0rvCcq+P1CPJjNMpJss5
         uyUtbbM0q6R0YhgYGlET9di90UXXQUpV5eMIzNECmQaqq2eBj3sg1pRQdYLGFB4nwlMc
         pZsg==
X-Forwarded-Encrypted: i=1; AHgh+RplAvuYp9FHKE50nYVzWuIdEYzf9ndC8R6sdAyATqRoqPyl3wmKwbC9JU9CMRDwhEbupFWXf5s=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywr76yWXV3VdcHwtw4ETD2p1Qwrx97+PpDT6Y46cym+mkNuEmTz
	Pak9WWSYpFspXWPcX+FXYYkC5Ni8vkHcPIABTacea7ZyE+/aCdWIWb6KFJmjL1EuS2D60MhPQXb
	lcCOCpqnBqZAfnnD+8xtSE1IgHVTpBU5dMMmpaNaBLwRN6xOraK7MP3ICSdcYeRpH1A==
X-Gm-Gg: AR+sD11jC/dQCHyscKpv9G7Nc74IFFxFnL0tCCimBPTrOq4Si/ulTqR4g1I+hrgS7Uh
	oxq0s8905xF4rAAAOmy9eylpJ355cQ9GPOF/pXBuS/VcwPGmpVyfMO6uUqiR7IF4tmwDcNYEy3w
	LDUQA6TNtSrDdVG4xUUss39fsf/tJPGdhEzVfj+PSpnabL0osQVmF/FCdclm6RrjCbW5F9RAzKQ
	sznkGmBjhvIonaPk531UsNNzV2X1V45Vx3NRRoe5xxg9BjLKYykqDFSQNxX6DJz+0SdMz4bXERS
	pBMfpkBEk9sRYMa1WXeqhQ97tJg+De/rVWmnRG8AvkzAP1TdWOCPtENNTzUzVHcjqIDWRI6Afe6
	t+V1QHLRUd3Xxa3xbMast1YW2KNMxawE485g=
X-Received: by 2002:a05:690c:6b0b:b0:81e:5a57:b8ad with SMTP id 00721157ae682-81fd4b51df0mr122408317b3.21.1785768005026;
        Mon, 03 Aug 2026 07:40:05 -0700 (PDT)
X-Received: by 2002:a05:690c:6b0b:b0:81e:5a57:b8ad with SMTP id 00721157ae682-81fd4b51df0mr122407797b3.21.1785768004486;
        Mon, 03 Aug 2026 07:40:04 -0700 (PDT)
Received: from redhat.com (c-73-183-53-213.hsd1.pa.comcast.net. [73.183.53.213])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81fcd0d6fbbsm55781147b3.25.2026.08.03.07.40.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 07:40:03 -0700 (PDT)
Date: Mon, 3 Aug 2026 10:40:01 -0400
From: Brian Masney <bmasney@redhat.com>
To: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
Cc: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Chun-Jie Chen <chun-jie.chen@mediatek.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Edward-JW Yang <edward-jw.yang@mediatek.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Chen-Yu Tsai <wenst@chromium.org>, kernel@collabora.com,
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
Subject: Re: [PATCH v5 12/25] clk: mediatek: pll: Add PLL stabilization delay
 definition
Message-ID: <anCoQeS2OoucB0mO@redhat.com>
References: <20260801-mt8189-clocks-system-base-v5-0-ac4410697cc2@collabora.com>
 <20260801-mt8189-clocks-system-base-v5-12-ac4410697cc2@collabora.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260801-mt8189-clocks-system-base-v5-12-ac4410697cc2@collabora.com>
User-Agent: Mutt/2.4.0 (2026-06-19)

On Sat, Aug 01, 2026 at 01:20:58PM +0200, Louis-Alexis Eyraud wrote:
> Several functions uses a hardcoded value (20), to represent the
> needed delay to stabilize a PLL.
> Add a common define for this value.
> 
> Signed-off-by: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>

Reviewed-by: Brian Masney <bmasney@redhat.com>

