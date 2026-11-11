Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794373670;
	b=sWGVcrv7bjqy3zZo8UX6rLN8k8lkKZ3C3bKVRfLEkdi2b/pHpn0EtLeg2RIkKWgyzQ2N
	 kogfAWG1DwCRPxBYsMyd8M1jntredftKvSzgQdpZCmiTRPrSd5KfJiZPPebp+K0XwE8ci
	 LMna8jvfWkXwOFvKYKqwDK4w45chhfFVc6DOv3JsLN7tZXDgjafuLFaBjIjxvvdtgqUQR
	 bwbJZN2zHaSjZOQT5Ri3VQxeWNdKTo5BhoYjnxb7gNRYqk+aU/h0j/gwz6iR7zYjFgJQf
	 wa4GyR/dzVxLHBv0CTgdBz881OkVz0EydsUERPW0GYw8M1/NEv9GcCJiaRGfGj66Onw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794373670;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=4A6J667rSb3Y9gQQI6vYPwLfo1ZcBRjnfftz6dRgI0g=;
	b=rPjDt72mVlkN32IJ/bRK24pO5/fvURvBGU/FfmHQ0wVXttQKjyweDVAWdAheyQyb/0n9
	 OidJErCqokEn1qAEqz/uawDD8hgwyzA4p36jNx2njYr0XhYmuZa//86OuXGDyz0EzclZz
	 Cl5v2ueIDH5EKSZ0ts9BxfeUBhMnPd4NtZcWILjjN3KdQcmBc1mOgjkRBQmP+gsBAIbaR
	 EVINNK41fDVwKERwTg/2YRMsHN9xiizaTl8k0sGBmjcUe/6CpRC9kiMcFp+8igKcPjTuL
	 V90y4ZUyfZRVJbmoK7l1xcbxEffGqAgDmPtV0Ppl5MlTwEcpc2fSuZ6ik1ny2u0qELQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=smartx.com;
	spf=pass smtp.mailfrom=smartx.com;
	dkim=pass header.d=smartx-com.20260707.gappssmtp.com header.i=@smartx-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=jYePaDA6;
	arc=none smtp.remote-ip=74.125.82.180
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1A66606A327
	for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 05:07:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E1A66606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=smartx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smartx.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=smartx-com.20260707.gappssmtp.com header.i=@smartx-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=jYePaDA6
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-3704d30b84fso3574057eec.1
        for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 21:07:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smartx-com.20260707.gappssmtp.com; s=20260707; t=1794373668; x=1794978468; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4A6J667rSb3Y9gQQI6vYPwLfo1ZcBRjnfftz6dRgI0g=;
        b=jYePaDA6FAC435KsBdwicGiIKytsh/Lv7E/r5woVHInPAamUshJuOkBD6xdSL+mjO0
         aKW1v14tOHLsf0hp5Ab+zHkdZbtZjB0vqxmDKQyC2nmkI/04tJrcHhiQfSTTZQoHwFRx
         r2nbG3NjPh6Ly6GiRnKfoy9vcjDRDr/syYc4fxN3HszhyHuTNozIzLHOVVMx5fITyFhg
         vTx7+QfX2yyq3SK5r6qsU8anmUqVJDb8f58FG0vn568G/4+xgn2W8DIk/zLeSLkXBMVJ
         gECNyckcAs8h8ZnWWUFIO09fm9yvu/JaRgnWjM0JbNco0kW4k50YzVBU4pV54/cPzewj
         yxMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794373668; x=1794978468;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4A6J667rSb3Y9gQQI6vYPwLfo1ZcBRjnfftz6dRgI0g=;
        b=s0JGJFcJZAV6F9QVlb8S/lyhqZGI19SVUiIIkkFfUV3q52T76aqz56/UuJyypLxxfH
         Xd68wOykexgpHFeEkezwCRsHQoVlO9LoF3FhzhOmKyTi1nMHux+e1NKl4CAjweZQFoMa
         eSLESmuUsKk66YeIT+j6TL3CTGbOHV/74pbi4g9ZOZbFleJqVK483qCVPaFbY6lUS4z0
         Y+e0q+njKPsnLfNVuUiEy+I4pjSMbgJBTgjTusQQzhJvRYJxPd7STRNKvDGY/a+jkqOr
         lQZxpraKuBMhT7Sd6ZWNYVTnZyozFpNTQSDoX4t4CupUUOR4OYTcbgDAvThS2lmt5rc+
         u5ZA==
X-Gm-Message-State: APuU4Z8e36obAmbXVWifCa1iZu34YqpvuzDLTM7stCn/pKzh0+h3k06P
	GU0BeI3VeiN/po2al2qqgvTvCOB8O9L+7GLXNdMlmpsCaRulJbzzYKLRXi/kfxx6IZK4h1Yr0tO
	2lI1LEcJOb+oSp6w1lr7AYLKW5BI75+Q7ZebMdiHlVzjILceZ0ciHULnvaLATIhV8rvOBZkzr
X-Gm-Gg: AYBFou27E2OjccPDuHowEaz1QnJrtA4mFREGdyx8ZzojuLE+PiDJDz7wqFzNLF21wGJ
	SJxffx3z9r6hNwO18p8dVtT8q1x6h8DOin8r7jZ4JDUJ3nFsJiWMRmx12t6OS3V2n+8pnA5F2wP
	iWi3n7Ejv6SdWXETWvChgB6ViX+BEjmM1DHolmgz4T4+KaRaLuy4Npi8Yc6i2Ier2N/TLxZkoFy
	24LPlcjWj3Y4UxnmV/EmZQBlPZ59JExzwe/x388fSVA7GfoeF0+oEyMdfmI6GnhBbvRuOyeM1KF
	nBn4BWrACNABzosRbvNtUKMYxrENjgjCn6KyOdgMl5xqyKMidRffU9PTif5wDjiAr0XSbFft2Js
	0m3Ah3MgnGztVQPtW03hSaOZvn/nTrZKhym3aSm5WzmyzG1WyCVSI873hGuxqmBNAw/fW+RRooJ
	OiY2iJmJUdnkxdf0pv8kWNmvgfEzsxnMjTVvRQz8ZmQ6H4YJtpwcnVtNIjZiDdcx5oYe36HOKJs
	x3J1Pk94JLi3Rd6FiaLrOpngEuD0fRBY/zc/IvSNp7Q8XYzXIoDW7bJLPtNNdye+IlYDrNfZOpa
	y4/mN2aJtw2IO/mG0+iHv2mhI/RSw59bBbfTuwaFoA==
X-Received: by 2002:a05:693c:2d82:b0:376:b957:c08 with SMTP id 5a478bee46e88-376b9570f8dmr1847611eec.9.1794373667202;
        Tue, 10 Nov 2026 21:07:47 -0800 (PST)
Received: from localhost.localdomain ([174.136.204.24])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3751fe306e3sm12510956eec.7.2026.11.10.21.07.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 21:07:46 -0800 (PST)
From: Wang Zhan <wang.zhan@smartx.com>
To: netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Cc: Wang Zhan <wang.zhan@smartx.com>,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	sdf@fomichev.me
Subject: Re: [PATCH net-next] net: opt loopback into instance locking
Date: Wed, 11 Nov 2026 13:07:27 +0800
Message-ID: <20261111050727.643231-1-wang.zhan@smartx.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261109173902.1225585-1-kuba@kernel.org>
References: <20261109173902.1225585-1-kuba@kernel.org>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 09 Nov 2026 09:39:02 -0800 Jakub Kicinski wrote:
> netdev netlink iterates over devices when dumping queues/NAPIs/qstats
> etc. and takes rtnl_lock or instance lock depending on the underlying
> device. Currently even if all the "real" devices in the system are ops
> locked we still have to take rtnl_lock for lo (only to find out
> that it doesn't even have queues or NAPIs to report).
> Opt loopback into having control path under the ops lock.

nit: NAPI dump no longer takes RTNL since commit
062e789172226 ("netdev-genl: remove rtnl_lock protection from NAPI
ops"). "dumping queues/qstats" is enough, right?

> This is a pretty obvious thing to do, I've held back this
> patch because we used to only apply ops locking on physical devices.
> netkit queue leasing made a precedent for (far more complex)
> SW devices enabling ops locking. Now adding it to lo should
> not create much new bug surface.
>
> I considered an alternative of adding a "predicate" to the iteration
> primitive so that we can skip the devices which obviously don't
> support given API (eg qstat) without any locking. But it's more
> LoC and real_num_.x_queues is not currently WRITE_ONCE()ed so
> it doesn't work too well for queues.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Tested on x86_64 QEMU TCG with lockdep:
- with RTNL held for 3 seconds, all-device queue and qstats dumps waited
  before this patch and completed in about 4 ms after it
- no lockdep warnings across lo up/down, MTU change, rename,
  promisc/allmulti, ethtool get_link/get_ts_info and netns teardown

Tested-by: Wang Zhan <wang.zhan@smartx.com>

Thanks
