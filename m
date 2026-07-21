Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFE0248BD42
	for <netdev@vger.kernel.org>; Tue, 21 Jul 2026 12:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784635561; cv=none; b=UvQCIcBCHhwobeOMKuwV5+ZZ165EjUG3qkFEXmPYkkAkOVzhp1K+r80gYSiEhlkpfcnW8GtnFO4uRwDYsKjmHmXdDav8YV8upun5Ja/fYwcxJ8EkKvYlqq+PAJoOMhVEejeYB+n2FyaQZTTBR2T+jZali1i3UTNM1TJtzRqtDfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784635561; c=relaxed/simple;
	bh=F6290uvaT3t6DMwvCddqTMhQBC8Gb/oHsT6WiUpeHxc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fQ+CxFy+mUYh/VnkXZ2XsisFZp6q/3+mn+7tjKAdwXanDzGZK7fGNCndBaFg1XNEeOVgs3gkob6064gHl4FGG5qvP+PpoVQ0hf6fA9Tn9z8RBsvqj+JuZSSGSVSeepeVWk6pISIRGLITqizqV+FZFj6xcLmWRsYFt8KDQh5Sbrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fk5NGQ1H; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fk5NGQ1H"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-47f7444576cso1630710f8f.0
        for <netdev@vger.kernel.org>; Tue, 21 Jul 2026 05:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1784635558; x=1785240358; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MRFIlu//vUygNsMu4i7xEPYXx1OGs/uABSasbozKdt8=;
        b=fk5NGQ1HjS+xig24ntgsNCb6m04vvc6NQa7ydDhnQ6LvXKvBlV7xlsOtWJE4vDPddI
         JDNrR7WHlMP8sLFFG/gmfQYKMXtamh8Ji6BBdDTtQf0ate7wGc8OeRQ83T/LVgww2Cfg
         9Tvs/ND0U3i4nn62Fo6ywOg105L57u8BGHZ6iKweo/MuMxHK/e8r7Kj12NzslVeMnPmD
         GE8XTk8/BYEcikSAfNLS4UODNyh+JSP247R0gc1IM4hGyRYi0SjdKrwOUuqE7tYS935T
         Xf9VEW1HibSjHIeQjD7ELytOxlcPZsXtu+srUj2Pvdu+MAOaf08N0GmNMKyScqFHKCbl
         H5AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784635558; x=1785240358;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MRFIlu//vUygNsMu4i7xEPYXx1OGs/uABSasbozKdt8=;
        b=SRNnNgPpcqISMu8+DobbPm2Zr/8VIaUGQDEUNMX76r4xt2qktYZycXjh0nYOoFKQOb
         gQkA7v8MLNilcRIBnl7pKHbqksSvMxgNfyi2ApxY4JzxFSeFjEaxje/glAiRrICbXlLt
         lEkx9OVBfgCgcyk3DNUJXSgnipSstSFOCDswwLijRPZg6SJzwc41K+m/yJYt/tXdKK9a
         /gil0JsNGyss75x1u26G+WY1Zp4JcS8DfY8xDG7q5u7LSjJkVt2s0K8BzAumC0FK8ICx
         +qeX1yl0woKxZt7Uxl4X4tLg/kq9GqobKBBOxHeb5uk8RCcJA1eWYFhdKgePM4n59uxs
         lcSQ==
X-Forwarded-Encrypted: i=1; AHgh+RqE5Fps8rSfrlNUjZqLzmpIvsX8CXa/vx69WpNypFN7mqC2UKvfr73TvnRmagvfzyLBndYpPO8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzS+EVJ+s5HtzXScGf/HVsjyWklUJgZBUKu2+6bIFeFpVb1IOdY
	asP+bOClBik4cpaOn84KBYY7lOQTVzZQuXy+PRvRH90mmSR/RxAbF33p4hRUAtl3uuA=
X-Gm-Gg: AR+sD11RBiM4wws8+2Ifopy6C7gWy/jUHTivqjTGNxq9fgf6rQ7gt4pnEdwT57xyQDj
	y9JJtxbIzQztLM5mbzITAnc3bMFbZvMV6jzbG9QHdFZ6pZd9WMjxaWzjNjNORSpYUFo8Att55S3
	hpodytINivdLVvEYmqxsMRGUqBBU/2Z6Df6SeLEESF3rcvQyym5wF8uq+7cAoJOp43VTGWX5xAB
	NrkIHVjUBSvT4BNjKrrvVkVFkuZnkObX2lW0vJHSuob1aVMD1gChqNADwm7BgB/WI3XT0nY6vby
	ilS99jvYjWr7J+6OAVxeY5eNFeX1lvegZRQSXd/hZJ3+Su6/y0lR8tmKQ60Z9yvTwmSp87pHhV2
	kWB4n4hxiV00aedAr6IpIyk+Ai4dZv1jWYMJ8Ekfnbckd+c19GulQIixOs8To3KTnkYTdNTSfRe
	L3UeoYOzv6xTLFOQ==
X-Received: by 2002:a5d:5d82:0:b0:47f:25db:8161 with SMTP id ffacd0b85a97d-47f62328414mr20909304f8f.28.1784635558076;
        Tue, 21 Jul 2026 05:05:58 -0700 (PDT)
Received: from linaro.org ([2a02:2454:ff24:7210:69dc:bf35:8552:d1f2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f63e65644sm37079358f8f.16.2026.07.21.05.05.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 05:05:57 -0700 (PDT)
Date: Tue, 21 Jul 2026 14:05:53 +0200
From: Stephan Gerhold <stephan.gerhold@linaro.org>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Vishnu Santhosh <vishnu.santhosh@oss.qualcomm.com>,
	Stephan Gerhold <stephan@gerhold.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Loic Poulain <loic.poulain@oss.qualcomm.com>,
	Sergey Ryazanov <ryazanov.s.a@gmail.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	chris.lew@oss.qualcomm.com,
	Deepak Kumar Singh <deepak.singh@oss.qualcomm.com>
Subject: Re: [PATCH 1/2] dt-bindings: net: qcom,bam-dmux: Add
 qcom,shikra-bam-dmux compatible
Message-ID: <al9goVA6eLtxymbz@linaro.org>
References: <20260714-qcom-bam-dmux-vmid-ext-v1-0-3f29da7cca76@oss.qualcomm.com>
 <20260714-qcom-bam-dmux-vmid-ext-v1-1-3f29da7cca76@oss.qualcomm.com>
 <alXhHH0mGvFeUMd7@linaro.org>
 <3a32a44d-4044-4270-beec-565171ad4bff@oss.qualcomm.com>
 <4fc9743d-3d9e-4130-9ffb-b64318a8373a@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4fc9743d-3d9e-4130-9ffb-b64318a8373a@oss.qualcomm.com>

On Tue, Jul 21, 2026 at 01:57:16PM +0200, Konrad Dybcio wrote:
> On 7/14/26 4:03 PM, Vishnu Santhosh wrote:
> > 
> > On 14-07-2026 12:41 pm, Stephan Gerhold wrote:
> >> On Tue, Jul 14, 2026 at 11:02:31AM +0530, Vishnu Santhosh wrote:
> >>> On platforms where the modem DMAs into the BAM-DMUX RX data buffers and
> >>> the XPU enforces per-region access control, each individually
> >>> DMA-mapped RX buffer consumes an XPU resource group. With only ~16
> >>> groups available, the per-buffer mappings exhaust the table and inbound
> >>> transfers fault.
> >>>
> >>> Add qcom,shikra-bam-dmux as an additional compatible for the Shikra SoC,
> >>> paired with the generic qcom,bam-dmux fallback, so the driver can match
> >>> on it via its of_device_id table.
> >>>
> >>> Co-developed-by: Deepak Kumar Singh <deepak.singh@oss.qualcomm.com>
> >>> Signed-off-by: Deepak Kumar Singh <deepak.singh@oss.qualcomm.com>
> >>> Signed-off-by: Vishnu Santhosh <vishnu.santhosh@oss.qualcomm.com>
> >> IMHO (the DT maintainers might disagree) this is not a different
> >> BAM DMUX hardware block on Shikra, just a different firmware
> >> configuration. I'm sure the existing SoCs also have those XPU blocks,
> >> they just don't make use of it.
> >>
> >> Personally, I would rather describe this with an optional "qcom,vmid"
> >> property similar to your bam-dma patch, allowed for all SoCs.
> >>
> >> Thanks,
> >> Stephan
> > 
> > Thanks Stephan. Adding Konrad (Cc), since this compatible-string /
> > match-data approach was his suggestion on an earlier revision of this
> > series send for internal review, specifically because BAM-DMUX is a
> > singleton per SoC.
> > 
> > Konrad, given Stephan's point, would you still prefer the
> > compatible-string / match-data approach, or does the optional
> > qcom,vmid property (matching the bam-dma series) make more sense here?
> > 
> > Happy to go either way once you've both aligned.
> 
> This all depends on whether the DT maintainers grant you the right to
> introduce a new property and in this case I very much doubt that
> 

We have the qcom,vmid(s) property in multiple other bindings (rmtfs,
fastrpc, ...), so I don't see an issue with that, personally...

IMHO I don't think a new compatible is warranted, because the BAM DMUX
protocol still works exactly the same (at least as described so far).
It's just the firmware security configuration around it that enforces
additional constraints. You could have this on any other SoC as well if
you configure the xPU stuff like that. It's not really specific to
Shikra.

Thanks,
Stephan
