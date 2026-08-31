Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC8F53A6B81
	for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 18:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788199869; cv=none; b=k3vPRgijnPdGAeP+qLNHofj8UeKLlCH9Q6NmVY50b7bY460FcnqVAWH4+V1yLyEf5W9IW1onMqs09mW0AZCbFMgHU0oM5l+giuMIoADl1tTymGmKeEnLPFm4gBaJ9eSqAN/eJRA/YoccBO2iGl4qnQnp1649A5rlcTgGLR21J/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788199869; c=relaxed/simple;
	bh=TLkRZA3JuuPX07AMWLzAA/Lk8SLkA24CMGDMP7I7j68=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=upLqwsGm42+50GJBx671ECn2328MYiTchCbcXVBETteKo3pfr+QhR4p0Xt7Bdq4vIY7tmUfDiW67oPrUCDWKcQWJEsY6OSaVh4EPtfmMGSLrppoxvGgSmoc5bofHJ21PM7PkNTRW82v1YNUe6d8Hpw+FS48DVbYs5sHZrrdmbuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=ZUzA1243; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="ZUzA1243"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-cc1e1ff659bso82581a12.0
        for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 11:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1788199867; x=1788804667; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sFcVUeZvoh/RAPEBADc2aDhb1dFXKQ/OHpInFaT5ih8=;
        b=ZUzA1243nHkT95cS6ODSQkln9ncxcrLdjKpbZW/CfLOrhQI3SBBEMddGJuFn6oWLC3
         B5HjZbZseXaPuioyBg2IDmqGXZFvZBNpO7hLudPDY+ytcQnyvCchD5rwz2F2KSmkX0Nq
         T0n2Fk09HGQGa8FoK2sxhEycao6wwyzxS//q719EtFJk47Tqr5rcunvlyJ1intZK2PAD
         1+mSFqLxxRl1mz7zASS8uGUZTVZk1/3GCyvSr9wfouD2FnabPXzLBn7pWWIPX70vy8jQ
         ec2Tga7kviG4qzev6b3gouO8KrQDCEPxgqEzGCESxao1vzMfMXa0Zcy2ApN0lTpLGzok
         MGJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788199867; x=1788804667;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:to:from:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=sFcVUeZvoh/RAPEBADc2aDhb1dFXKQ/OHpInFaT5ih8=;
        b=Ac/w3qsAt8+mSa65IpXktmczf5DUeKE6pVt3/uqR5Fwg/7e+NR4f2zqJhx0kdxfn9j
         pHSLlGII63zii2Nmr5HjPahFlwje5jev0joQNR8rmcb4q+dKnRlU8Sdb3sepIAwSt/Fm
         SH9Ewc05MzHbmjaUdTTc9H3aMyGZFFYwOlhwh9ieMUr+ubt19tUd1NhZBxzn78TKuQ9O
         HK0Vjg/Yj/EpJxiNBOTpYgeY+q+kuhjy2hm5QLY3+cWzaT+ZhlBhD5rqh/nxySvuRIx/
         l8Z6UPvpvu+faxgy77KmhjROxS3VMEIR+3zwPn0GPAwjFt3ewKt8qJw/cBCmasIZzNAf
         IvMg==
X-Forwarded-Encrypted: i=1; AKwUvBx5w+lgMApeVUKaVvveZw/JP8C2a8f9Zjiz2j5iVO8Vx5DzCLuukWZX9C8pcAopb8UkJ2PHifE=@vger.kernel.org
X-Gm-Message-State: AFuF++l88dPdKA6Cg06RPIFHd2dZscxVblz36rsOq02TQPDm8tWjfZwG
	CH2BrT8IARwFDXtVHpUlEo6pGs2nMoYk4CyuDIYQ1k+C6F63V/nMbITTiYHveCBOaSY=
X-Gm-Gg: AYBFou1S5HywvMYwuHVIiorVjjjiVQyJL3VEvB7Yr+8wruYBHFQ9f2/8bJ6HSgBIWqy
	YXbtPcRCsGKoryHBadHn3yzr+vx4Tg3h2WdcBnEhFpUY1t2MyzRAF+SRaFjiBzd1Po1LvfE9CC2
	F/y0zUPguYAqEgE1DcqbvXYtiKnvCRIUslSevMD3EsSlg9eD3hjBE7Jmz8f27lCtq0r2tj+FalA
	sXiJTarnMCJuxxZkU9ETKl37Dx+LcwDhh0Xs1ky4UlO6sB7fBdfItNOZOIB1FPD/fq8denpLFn2
	QgspKE+ZQgyarOGeXbFFuzYfGZ5Nuf+WQ9uVdSLTpuukVBBp5r9abRkt0uUkDTEnGUwm4bRhINe
	pdB0higjox6TszM7Z9ZLTH9vjN06I8xL5hAyjc/a2pLUvyjBLvGH+7MK8Puh1hdAw19K6pX7jVa
	Tmk4BXuEd4bimiYlBbYk/0dWDtPgk4YK6qMsDjzAhi8+0Xp5GdiLbV3l7vtg==
X-Received: by 2002:a17:90b:388e:b0:38d:ddc2:7ccb with SMTP id 98e67ed59e1d1-396d0eaabfamr38282859a91.1.1788199866927;
        Mon, 31 Aug 2026 11:11:06 -0700 (PDT)
Received: from localhost ([71.212.197.238])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-3990d4ede7csm757637a91.13.2026.08.31.11.11.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 11:11:06 -0700 (PDT)
From: Kevin Hilman <khilman@baylibre.com>
To: Aaro Koskinen <aaro.koskinen@iki.fi>, 
 Andreas Kemnade <andreas@kemnade.info>, Roger Quadros <rogerq@kernel.org>, 
 Tony Lindgren <tony@atomide.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Richard Cochran <richardcochran@gmail.com>, linux-omap@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
In-Reply-To: <20260706101815.341184-2-krzysztof.kozlowski@oss.qualcomm.com>
References: <20260706101815.341184-2-krzysztof.kozlowski@oss.qualcomm.com>
Subject: Re: [PATCH] ARM: dts: ti: omap: Correct indentation
Message-Id: <178819986613.2869653.4587463597728573985.b4-ty@b4>
Date: Mon, 31 Aug 2026 11:11:06 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev


On Mon, 06 Jul 2026 12:18:16 +0200, Krzysztof Kozlowski wrote:
> Correct spaces or mix of tabs+spaces into proper tab-indented lines.
> No functional impact (same DTB).

Applied, thanks!

[1/1] ARM: dts: ti: omap: Correct indentation
      (no commit info)

Best regards,
-- 
Kevin Hilman (TI) <khilman@baylibre.com>

