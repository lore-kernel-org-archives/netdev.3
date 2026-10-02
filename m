Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57799361DCB
	for <netdev@vger.kernel.org>; Fri,  2 Oct 2026 18:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790967115; cv=none; b=iQjiBUbv77ZXN+gNVRCGfiE7OcLWRYQzQlAEeBb1Az4sN0nyosuQh00nI89gyGHT5+8G77MwM9QT6AumYzcm1KwtpHnm5jdqrhexYvL5T9YPcDOH+Yf9llEsf7IT1ou0AbUqF+M4UtDuQiGz3l9JSqBkfXLYosYKjUMJtmlYoS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790967115; c=relaxed/simple;
	bh=SvlLnlt6KHX1Jrj2D3pJtCaILFR/9gRc9iadqwmEB5E=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=FUWv5/WwyMpRsipyoOEjZfxORPHTzCayo3HqQ5T9bxmx4Onbn7CXmhATgAVmwR2Svc+cYY6JdW4CugjtJud/BRPwnx33WJx0Fo3OH9rZkxoiMO8MhklgvVC+pfvymSThA5wsLVpKxT4JO3ADtbtPSuBi2unMU1BynmlNhwIan74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AWpa7z0u; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=s56Ve+PI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AWpa7z0u";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="s56Ve+PI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790967112;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lViRkD+J4l6mElusP3QWY+NSQ6ORF7js4Y4aeDT+mp0=;
	b=AWpa7z0ukoQgwGG9HhZrs2nPndVK12Rd5Ui+rTSjt0jyKJH7ley3EWQz2nE44bMfUtGbeH
	Qa0chSRyMFYh6QSIlCyY4lVMW+Q7sQDcSO4T0nS84t/hK1/ZMbhK9XFy+pKkVL9pG0O3MH
	j5yhN19XM1qjqyubEgTJbS862jq4Y2k=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-190-dyCNv3J5PriQF6T2Oet1eA-1; Fri, 02 Oct 2026 14:51:51 -0400
X-MC-Unique: dyCNv3J5PriQF6T2Oet1eA-1
X-Mimecast-MFC-AGG-ID: dyCNv3J5PriQF6T2Oet1eA_1790967111
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-93e4c03d1d9so64657985a.0
        for <netdev@vger.kernel.org>; Fri, 02 Oct 2026 11:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1790967111; x=1791571911; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=lViRkD+J4l6mElusP3QWY+NSQ6ORF7js4Y4aeDT+mp0=;
        b=s56Ve+PIQ+T44wD55tOeH2I5rXg0vNFHi8Mr+UOqF/+/1SaAZ9DGsiDSCIF5JHwv7D
         b+uAlMTzhi2pfJj/6yyozZ3N5wFnW/R5ZRl0tfEqQ00nOPcQE+iyOsAg3CcoenBbhxtP
         Y138PAwwY8icO90xoCzRmhaNq58D++D6R+f7KHG9qCqCIU8gzTmAg6jaCxtu0l3CzIho
         /xOLx/EJBAY0w4QLXGgzZYp9U/IhFg7DrAJ91/KSaiRdGNDVNJhKeCGzdikSCPph1YOA
         TOY3jT8WXrmldDrAD4nG8REgeg4loZY4lTaaH4KIMaqdB5zriF90I5nPfrfm01ur6+p8
         mSIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790967111; x=1791571911;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lViRkD+J4l6mElusP3QWY+NSQ6ORF7js4Y4aeDT+mp0=;
        b=okB/1/FMBUx4y1R9UUogj+JIiEfY13JRiOqX0trH0HxWM83h3C4wfL7Y5ADLJzaBNI
         31iSm8//hLFjKzZRdlXLL7TLfnUhUv071At8QbBXMn13Mq6fdtkHTkrdWImmOQ8DO+xt
         s8yYcsA0ppQPryLI+6a1lvkGXcAGmF+UZvb9nViKBZ0Ct1ctSxO2LcMjauljCjMRl+3Z
         0bA5O/guaB6BYJtNFpv4TZ7L8UcIXMc79d4Mvv58IUdugnQ+A8lbD8yLOzpjjO2msVO3
         l+AiOatb9/j9hKgwBbEaBudK0Ff9GmTyqPDUtHZ877pXE3H8UsAV09pvE5XeS/fl64sw
         A9iw==
X-Forwarded-Encrypted: i=1; AKwUvByVOgcpu/8HQfJC1SyA5AgMStZPGk0060jbRkVM960DryVPPr83VfiZO1xfzsP8aJPCpnjFN7w=@vger.kernel.org
X-Gm-Message-State: AFuF++kUxU5umqwzb4dP4J/oJL2nc7fJSeUsW2yT8hMgoJZP0bB/jJtP
	H7xE4egvtHgv4QBlpA6NMZhgt7z2596Ya41Ni/54FJF374uTlUccBbi04Agf3SEtMaGU2+oYwQS
	hxrWeR6N1/MW7ziK7xIGt5lyXbFP1cGdvFaXzYc2QVhdEj7C9T33jZDIpew==
X-Gm-Gg: AYBFou2OVAveyvDtSBMRfYJ4PQ5+w+OkpKpART5QNI2uNZVE8RZowRJ6+JiIkMduEsP
	thjUcdfg78f8olm7brYJVxPV1C2zI6tC+Wd2wMNiw7+F9TeVShz3sjTjOyITTmnU95AAw+1D6Ug
	GWIvyCWl+DptPyqEwMSR4h62CO9HZTMo/GNykbgu4wKGBLYf2J4XfvD+fN2ZHJhM0lAuipUrpil
	yBc0vKCYMZh0baSSX7to2D8N5+Qd09dOoKuiKEuzpqyY7bovJ+cJ8awJXkkH2NGozBq2OGwxaSt
	1s+sy/Z1lmRsDiqodGZ3sKzzboUJVDxmw91KWRpU8/4DR41iAveyw4P5VVgsfb3IkuCsUPhelsb
	tOpXdKVnBU56rFg==
X-Received: by 2002:a05:620a:bd4:b0:93b:c58c:d3be with SMTP id af79cd13be357-93cf17664b4mr670122685a.37.1790967110525;
        Fri, 02 Oct 2026 11:51:50 -0700 (PDT)
X-Received: by 2002:a05:620a:bd4:b0:93b:c58c:d3be with SMTP id af79cd13be357-93cf17664b4mr670117885a.37.1790967109968;
        Fri, 02 Oct 2026 11:51:49 -0700 (PDT)
Received: from bmasney-x1.rmtuswv.csb ([2600:382:7723:4eba:66b1:961f:1a2d:af55])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93cca03a1bbsm290352485a.1.2026.10.02.11.51.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 11:51:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v5 06/23] clk: starfive: Add JHB100 System-0 clock
 generator driver
From: Brian Masney <bmasney@redhat.com>
To: Changhuang Liang <changhuang.liang@starfivetech.com>
Cc: Michael Turquette <mturquette@baylibre.com>, 
 Brian Masney <bmasney@redhat.com>, Jerome Brunet <jbrunet+clk@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Paul Walmsley <pjw@kernel.org>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, Emil Renner Berthing <kernel@esmil.dk>, 
 Kees Cook <kees@kernel.org>, 
 "Gustavo A . R . Silva" <gustavoars@kernel.org>, 
 Richard Cochran <richardcochran@gmail.com>, linux-clk@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-riscv@lists.infradead.org, linux-hardening@vger.kernel.org, 
 netdev@vger.kernel.org, Hal Feng <hal.feng@starfivetech.com>
In-Reply-To: <20260930124317.5648-7-changhuang.liang@starfivetech.com>
References: <20260930124317.5648-1-changhuang.liang@starfivetech.com>
 <20260930124317.5648-7-changhuang.liang@starfivetech.com>
Date: Fri, 02 Oct 2026 14:51:13 -0400
Message-Id: <179096707364.821688.18177370718453496156.b4-review@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=922; i=bmasney@redhat.com;
 s=20250903; h=from:subject:message-id;
 bh=SvlLnlt6KHX1Jrj2D3pJtCaILFR/9gRc9iadqwmEB5E=;
 b=owGbwMvMwCW2/dJd9di6A+2Mp9WSGLL2/7X6vESXVZZr6Wxj3c4lz4Xy5qcm7nt4+OjFy0fUf
 A+ZPjGe2lHKwiDGxSArpsiyJNeoICJ1le29O5osMHNYmUCGMHBxCsBEEhsZ/ue2hf3l4ON+PnHv
 SvOQsrfpJYHf/Bvm7VBe9Kfo56vsPbqMDKs+HVC7yjLx7g35VuZFnkG3JLSO37uqbflrXT1jv6R
 dLzcA
X-Developer-Key: i=bmasney@redhat.com; a=openpgp;
 fpr=A46D32705865AA3DDEDC2904B7D2DD275D7EC087

Hi Changhuang,

> Add support for JHB100 System-0 clock generator (SYS0CRG).
> 
> Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 4f72b4ac27ee..a0e5b4df96aa 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -26097,6 +26097,13 @@ S:	Supported
>  F:	Documentation/devicetree/bindings/phy/starfive,jh7110-dphy-rx.yaml
>  F:	drivers/phy/starfive/phy-jh7110-dphy-rx.c
>  
> +STARFIVE JHB100 CLOCK DRIVERS
> +M:     Changhuang Liang <changhuang.liang@starfivetech.com>
> +S:     Supported
> +F:     Documentation/devicetree/bindings/clock/starfive,jhb1*.yaml
> +F:     drivers/clk/starfive/clk-starfive-jhb1*
> +F:     include/dt-bindings/clock/starfive,jhb1*.h

The spacing after the : doesn't line up with the other sections. It
looks like this is using spaces instead of a tab.

Brian

-- 
Brian Masney <bmasney@redhat.com>

