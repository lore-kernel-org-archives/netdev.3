Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B243F54B7;
	Sat, 25 Jul 2026 16:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784997181; cv=none; b=bGIoUUf1ia1u6mo6r94AOtxwvR5JP02y0qMeZWotwn03bh5my5k36mr1e5jWypmI9CvnB4wPfAMia8LIfrWUeLh8jb7Acym9e2NwcbpC1QNxa859VDqVJIkj4IYH+EDqQhR/6dFO6EJ/9JuNA338y8GmWP5VCSlKtS2ACFluktM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784997181; c=relaxed/simple;
	bh=TWGrXgrwvlkEikw+RycgLEeLkPUqHX1YZtcAc4K7mcU=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=bw/jXymG6RmpQyouOEBD/kgxprtStodXRFJ7AQytRaeoXRZGmW/GMxEun/xTqVEctfNDppx3qfWCneX9Cl749ZOLOk0NcCtf3n5giC7tfwGrkhKwRrSWSC2LWoCpAJcMNPudkK3WUrH7u1F7Uyk6hIm/PrhuNxlhXUseZNcLKk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RmZV48FP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RmZV48FP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00B7B1F000E9;
	Sat, 25 Jul 2026 16:32:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784997178;
	bh=MlnyT94NQQfH6vjbnVjWKHI4vG283Xpjos0OX9j3D3g=;
	h=From:To:In-Reply-To:References:Subject:Date;
	b=RmZV48FPRaYK0eXae5LCxMXNUQHdbJBZowsePekD34TEQULLVT3CZuT+M//TVAyqV
	 PvedvjJqypK4uL0WSqY+anrHHGtI61IJZCudZLZDTZJ1ggAU3MDXNRQTMVlgpFRd9B
	 r92y/rxXLRNHzu7z1DkndK1U63HUPIrAsr0w9bC6S1Fq4a09yp2+r6ueI+h4MgOdlT
	 2qb3S3IyADk4d2+eKE8vfQl1DAAvIM5YKwmHfk24KpFVrRKmn1dkk2l2PN5Ws6fw8+
	 eGf7Uh8yMRrM92GayqP6N8DMPoYFNN+a3HM4JhNudFXxjEIWrI0x+rSxfKy7SLlqG9
	 gwv+ze1sNnNRQ==
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, 
 Tom Lendacky <thomas.lendacky@amd.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Raju Rangoju <Raju.Rangoju@amd.com>, 
 Prashanth Kumar K R <PrashanthKumar.K.R@amd.com>, 
 Richard Cochran <richardcochran@gmail.com>, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
In-Reply-To: <20260706093523.274093-3-krzysztof.kozlowski@oss.qualcomm.com>
References: <20260706093523.274093-3-krzysztof.kozlowski@oss.qualcomm.com>
Subject: Re: [PATCH 1/2] arm64: dts: amd: seattle: Remove useless clocks
 DTSI include
Message-Id: <178499717460.107055.6539795697868368851.b4-ty@b4>
Date: Sat, 25 Jul 2026 18:32:54 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Mon, 06 Jul 2026 11:35:24 +0200, Krzysztof Kozlowski wrote:
> The "amd-seattle-clks.dtsi" file is included exactly once, so paste the
> contents directly in proper DTSI.  No functional impact.

Applied, thanks!

[1/2] arm64: dts: amd: seattle: Remove useless clocks DTSI include
      https://git.kernel.org/krzk/linux-dt/c/26b8eb8a98c18b2ee4ea76d99fa2b2a5ccbc1b6c
[2/2] arm64: dts: amd: seattle: Remove useless xgbe DTSI include
      https://git.kernel.org/krzk/linux-dt/c/8461050861aeea29138dd25d5fb78c6f643c708c

Best regards,
-- 
Krzysztof Kozlowski <krzk@kernel.org>

