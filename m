Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A38833E5EF8
	for <netdev@vger.kernel.org>; Mon, 24 Aug 2026 06:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787554086; cv=none; b=P2e9mhlOvQZK4VgCPpyhzovsIvxWgVIhovuO7hkdIUy5NPWEHy6OcXc77K/LoNMNUbzWq9DB3m2e+JY23+O2/lcI2PZjkIgpRPJ1Y1WtWzZ2Ze+eIfYzlQcy2hFuz88UDhYRpyiFYONfpGGqXw0QUKQwVSmHClJHjI3WGAYiZ/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787554086; c=relaxed/simple;
	bh=gsh3FwRHXOEoHxf9WDBD7FV63wrPPPV+1wXS/k/EffQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n3Y9mKnbIBW78dMZkhiMayu3o4EHH85uayfGS42N3RaQJrMUt9DZXdmveYqDHijNt1k0lpSqCUr+ptNoIj4djWkg11wosoXABmorR9/U/kGwcycjHb9C6JZ4VZ5iuPf2ubEUKcayX46Vl1BYqtl/iMS/KMplY26p+U44SB6OhyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W+Yo88Zs; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W+Yo88Zs"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6a3efa2b38aso5586464a12.2
        for <netdev@vger.kernel.org>; Sun, 23 Aug 2026 23:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787554083; x=1788158883; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ROwzLFkAwtTrfltmkckqtugY5BGlQdk0vedqqolGcRo=;
        b=W+Yo88ZsmjtZ33a3NWARzSQAs8oRKliSMcDl035Dj4EH0RPi7F9Lh+8PsZT/cny/OX
         SznLq5BPLQ4d3f909/cEABZ/WRiG7psRIBko6BPFtqA7t38pp5cclj5aLFaQEl6lHxZD
         4nXj2ykgNN8/2qrAKo88QQZG7ljJD6atBEJjeNPyuBpY757iMjZMXKw5ox80druMfUlR
         dzM8qFLbECR12OFMuFExM5OYSITrEAEss3APkMkP/36mApq3bErzSG95nEAfthdASp+l
         9romZtb6a2Re4VvAjNv3qM1r7SqyKPCaasxMODV6pXPzRXo5lNgXPl7RDWAHLV+PPbDc
         7OrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787554083; x=1788158883;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ROwzLFkAwtTrfltmkckqtugY5BGlQdk0vedqqolGcRo=;
        b=P9uNbUkgR2Tepn4Ai4Q+FzaHmK2gGPc5OS2FZXm5deT6cLy+LRLkrWpb7ksj1qC/VB
         eUic1o9uMWq2FGj+en2T1C4irTY7M5J9eIf86xLxrq8u37dwJzK6+IJqI+zdhXN7nSFY
         jeJNj8HhoUsJ1OsZFjlVb0xZjdBkXrRXlUo0o4VHKD0kpRg8WP6Yxh2IphCy4XDznazg
         IfX7Y7otIPg8M1y7PgmT8McMGMva08+1AHH9PWfBZxTRD7hYvqf96/b1fUbUq0Ry76fu
         ZoA5fmxFadk+q9sHxYNGbqC5pgwgWdJk1fnhDkQP0IhzbwbpkXEZRYJKDQNVxOb2kf/i
         152g==
X-Forwarded-Encrypted: i=1; AHgh+Rpva8QSwAOTNXqI7OApcc1QBNIrPwwS8lZaTyaCt6oVr2RqQsfMCDc2qevCqETwz1FUVafrGL8=@vger.kernel.org
X-Gm-Message-State: AFuF++lT+Fwo+tBdMuEmGXZct0wtXIV6kTweGZlQyHVsq1j9QQa9kspq
	yjrxYG5pKVIxX+pbDJsQ3wTWemz01/z7CpAMNZH8C7TsPFNQ/4B0QqY1
X-Gm-Gg: AR+sD13A+0tzutwN5B88HxiCA7cylj56gXSMN0JAB1XJEmmJSlilMb2OSn9Q1bZIOLw
	ylvjWdSW5SQa6b1ESsvhMjWNOcwS7i0cGGwtregnHYplUmJn+RTDvTaLSVjat1CJN1KWWXGWv4t
	CjbJWE3Eu++3wsoj+76ADOojp7DkacVAFwhnCnlIAS7xbEi54BFCYBj4mHZ0HUmIB6YGyffcEyM
	t/m7vLMYlT0fQRXthx+cYwZu54FSw0miFU4knkOdzvPO51HnYsXzaCbgSR/qveX4Vy/vidQlrPr
	pNNoL1pYvcK4dpatz2gjHH6WE2w1VwNDS14O7xmrHIFlO2QmJD5p+fMEjLqwrDyqX94PwE6BuIq
	iOsRfCWF36AN7DfUaQ2+UBLww3rfpIjToS5LT3DZ2iVZ1AEhMydGIUlYVTsahDR+QTQ7uINpFCV
	txhPr2dRle8zn/Md9+vR2ak75m0enttvGhF2uCgM0i/VjIpXjak3KBZQcpHcCY0Q0D
X-Received: by 2002:a05:6402:4498:b0:6a1:44c8:edc4 with SMTP id 4fb4d7f45d1cf-6a42f21ee3amr8021391a12.12.1787554082677;
        Sun, 23 Aug 2026 23:48:02 -0700 (PDT)
Received: from mobilestation ([2a00:1fa1:c28e:9a7a:6251:3e2d:4f32:3e5e])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a59e1cdbe9sm7097133a12.24.2026.08.23.23.47.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Aug 2026 23:48:02 -0700 (PDT)
Date: Mon, 24 Aug 2026 09:47:57 +0300
From: Joseph Steel <recv.jo@gmail.com>
To: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
Cc: maxime.chevallier@bootlin.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com, shuah@kernel.org, 
	joabreu@synopsys.com, yi.fang.gan@intel.com, jun.ann.lai@intel.com, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net v2 2/6] net: stmmac: Enable double VLAN processing
 only when supported
Message-ID: <a77cwrdtjmzi6zextnlg7llrqh56behj6zl6jkon4ta6gwnbdj@unwirtt36qwn>
References: <20260821170959.79708-1-ovidiu.panait.rb@renesas.com>
 <20260821170959.79708-3-ovidiu.panait.rb@renesas.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260821170959.79708-3-ovidiu.panait.rb@renesas.com>

On Fri, Aug 21, 2026 at 05:09:55PM +0000, Ovidiu Panait wrote:
> stmmac_vlan_update() turns on double/S-VLAN processing whenever an
> 802.1ad VLAN is registered, without checking whether the MAC actually
> supports double VLAN processing. That capability is reported in
> dma_cap.dvlan.

This is not true. S-VLAN is never reported by the dma_cap.dvlan
feature flag. Double VLAN tagging and S-Tag VLAN features are fully
independent.

-Joseph

> 
> This was found while investigating a separate bug in the double VLAN RX
> stripping path. The outer 802.1ad tags were unexpectedly stripped by the
> MAC (because the ESVL bit was set).
> 
> Check dma_cap.dvlan before enabling EDVLP/ESVL/DOVLTC bits, so that double
> VLAN processing is enabled only on supported hardware. Also, advertise
> NETIF_F_HW_VLAN_STAG_RX and NETIF_F_HW_VLAN_STAG_FILTER only when
> dma_cap.dvlan is set.
> 

