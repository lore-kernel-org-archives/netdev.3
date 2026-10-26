Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793017267;
	b=fF9sOASvVWQKS/FF/5MMtIRCC18/NHoxQ3xqmBn9FM4bBymP7YtQzpd55rpqdLW5YCVu
	 EP7Ps1xtQcFGLWuGuJfq+72idnwozBk+B1I4uvmPfJRxuyDlYia2u6sK/LJTcsaTfLHFl
	 DmTvKAof+OEQKetQqjtS48brkM5mRiYnFcRAE5NOCOMjqUwUg17bpY3Pkarjqw+aeplHr
	 OPMFFwi0CXfCPZ/hIlQ2/AIeCW+vzGNXMeynV5tGbMXnXVenUlHjfoO2oqKSyWKG1O+Xh
	 ayypzbLNrlcUMu+SDcHqu8bV6SITbt0x3ZfgGRL+YBfX1CAbFXovmaHymhCVq6yqjgg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793017267;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	bh=CyuTVqrEGPeDy0Z7+MBAQ6iLsoLVTf0+QXG1mFBmti0=;
	b=iJl1EOfUipHufcJrm74OtDRukBFQ7g0VnZVVzdYEZCEsdEGq+iHZ7CVF7utS0BFSKKB/
	 02UImtiVIrtqz/gGb3Jg07E+UizHWvUP8KS8HAhVZeSDRo7lalZrbjiVj+r3z86XawOl9
	 EZpe/ncS53dLxZvglrP360waREE4nP1kFC+0C7r0pLCong2zLpEDJc477ijvI9UDEX3zW
	 ktXAVSuIKUzSHBx9gZzoUXGPOOJ5WwYK5VKu8zW8cLZy+16sVXFlTEoS9r1UNn/QUBJ7A
	 QTt2sbf/bmK3wxYhj8lPBoV5GQWGl4QvrSfm4n+YO3lqCwT2ZeQarYVqrPNeidTdP1A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=GKciuavA;
	arc=none smtp.remote-ip=209.85.221.172
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE88A606A31D
	for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 12:21:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CE88A606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=GKciuavA
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-5eaabf28c06so2509878e0c.2
        for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 05:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793017265; x=1793622065; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CyuTVqrEGPeDy0Z7+MBAQ6iLsoLVTf0+QXG1mFBmti0=;
        b=GKciuavAF+9leS2pq0kl1jIr9oX52ttnm9N1rV9iURmgf518/zVSA8zUYlPoprBnMK
         1CrszCrIMVII9ic073c1/eJv2aCE+U/Ml9z6Gz7AEJahOEylEDSAEH3beRgS69ZBCrtq
         R4g5STi5+xS+Jwxw2v/MoYssQO8mpt6wLkM3wB06CgCG711zWCm0cDD7umPR7rffrhuv
         kYkrfvQLiKMCjcyv9RuThXlcJ6aRNYJwcpOnjP+q6LpVmO3mInaelgOWVD1lnryXu2De
         xnljQYB44FkjlVF4h4HsUZjtwuy9mgEatHdqitcrdvHYuC4AYIgDU/inCZZYNy9opN+Z
         J6MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793017265; x=1793622065;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CyuTVqrEGPeDy0Z7+MBAQ6iLsoLVTf0+QXG1mFBmti0=;
        b=A+Zhc5S5YV8bYu4plsejtVIyvOg5BCfWvK9TZ8s4HBJvRdF/qpSaA2Rjl8qU1kxneE
         /IwevxzrE0pvB6zHXkKBDnjsGt8zrrcXU6U3JwmnZEgRKGFUDwiLm/YbRY9J7tChwCLw
         FrbCxAURx/Jcwm4E50JsVoXHW+cWN/Fgc3PJpVLnNMHMTuoe3wys0xfgQpOB92Dt8Z6s
         rbUKTOa6lXuAust8tbgDzc8L8pzI/T3A4tyP53im/zEO8s+oBLz/MEs94M1m+Ek2CswY
         c4MXSHuVA1zrSz0YS8bGFvyPWNEmcv7XRSyZAVIwdHhfIBdiMxbvKpXD12KlGIT1dJvy
         Q38g==
X-Forwarded-Encrypted: i=1; AKwUvBw0bVowGaKARGrp4O3QUZHl2HNZOrocvSbvBMUxZu0fpqll11NaC+UKss02RbuRavTVklmGa+s=@vger.kernel.org
X-Gm-Message-State: AFq9FYJU2pxsu0owidVdbBY+GI1rguVaoWXT65IuRkDuymwot5wA7cnX
	huCk1NF77VHGOa08KyLymeR96NuAhL2uBigMtYA6aai8J79eDsnzA4ae
X-Gm-Gg: AYBFou0B+D20HOWaU+wvEYGarwE4/5qA3HhQfv8kQUSIwWba47BMbWv124/xZoOoCkp
	b8Cf6/gcRO/YioUJjXA8OvbrprTH0eaQWxvytfeL08boW7ey6xjf/Sf1+y1zzIvC1lefkxA4Yv9
	yVLunXunNCAz5xMeQFkym3qTwJdVW5Fr+E6CL/lsw8oLh9UYrudngyCAmQyd6Uu54MQyVB6+qwC
	DvzpmILcctxmbDlDXXCaP4cNk9skQgoY23+xS4tvbSlD1B+C9EZXaVtRsDbxIEnVLs83trl9RxN
	d9cC0ssSIPV1mIeMbiBM7arZu3vu8IK3vYBmVIdRKAg+UCKF7skcOpJqUVH7gdMTnLbq9QdYNwM
	RN6cyvQeDYbXyxoQoIpB3tg58wpr4ln0BfkHadn+DbgAhy20nrsH5Re4/qmsFlmwlZTbByNgIGM
	q6E7aG3BGsZe6d0b6Zm4yRwqJqS5wsxt8qfIT0XeYiMt0WUkB1KM8y3xGt9u8OovKrXTthjieAZ
	LGVGQkmgQFYky2gH9/wWVK4PTAksYcxuXMfBtd63bum67FJwC0UMLLJABB/LGY6pehhK2PXSrsg
	oyC3CTJtgDv8jvT4xPQYVI6IzCoLvqfqNADRB56ZOnXdc9nvWtuf/jrWz+CS2g5uI5CQHXyBobo
	tU7BIsq5zdI/Qxh61GJlQUFBQkmC0TOCbbu1Q4aZW7Q==
X-Received: by 2002:a05:6102:38ce:b0:7b4:879c:bb8d with SMTP id ada2fe7eead31-7ce5cec4393mr1848330137.37.1793017265352;
        Mon, 26 Oct 2026 05:21:05 -0700 (PDT)
Received: from c.1.0.f.7.a.5.f.d.4.6.5.7.e.5.4.d.7.3.9.0.c.2.a.3.b.1.0.4.0.8.2.ip6.arpa ([2804:1b3:a2c0:937d:e94c:8101:376c:4b55])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7ce5e16eab4sm7408804137.4.2026.10.26.05.21.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 05:21:04 -0700 (PDT)
From: Joas Antonio dos Santos <joasantonio108@gmail.com>
To: Daniel Machon <daniel.machon@microchip.com>
Cc: David S. Miller <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH net] net: dcb: initialize PFC value before calling getpfccfg
Date: Mon, 26 Oct 2026 09:21:00 -0300
Message-ID: <179301726001.91878.13970924707743684105@gmail.com>
In-Reply-To: <20261026073235.3huvz6o5h6psyv76@DEN-DL-M70577>
References: <179289284460.50470.572724041164324949@gmail.com>
 <20261026073235.3huvz6o5h6psyv76@DEN-DL-M70577>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Mon, Oct 26, 2026 at 07:32, Daniel Machon wrote:
> I am not entirely sure, but should this patch add a fixes tag for a driver, when
> the change is only in the API?

Fair point. The uninitialized u8 is in dcbnl, the drivers only make it
visible, so the driver commits are not the right Fixes. I'll drop them.

> Also, if this dates back to the introduction of DCBNL then I guess its not a
> regression and maybe a fix for net-next?

Agreed. I'll send v2 for net-next once it reopens.

> Why noy initialize this at the declaration, like getall is?

That works. In both functions the PFC loop is the first user of value,
so initializing it at the declaration is enough. I'll do that in v2.

Thanks for the review,
Joas
