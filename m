Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9671C3E7BBF
	for <netdev@vger.kernel.org>; Tue,  1 Sep 2026 13:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788270358; cv=none; b=kqdDdyArte24cI44SYv/GSk/osZ91PnMyeBXXxEBoQqjqpPYBlI14X22tnutIUya8xIJkzOiv0CL6n52IsuPqbpPWdJ2+6hBq+tAzuzm3UvwPpW8eNOe7xetG3PHuastJeMm1+VrBrVmZJk2aYPwwSGBdfZ5GVF9IAd1qdqwL5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788270358; c=relaxed/simple;
	bh=9UBILrwr9NfTPfw6AwyrA6QK7FIIIgM1IIUzcfAxtmc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZQgTiNGT1IIGJQgRJ3PGPNEV15bNxBjXJulWi9d1RlAskSHLHUpFB4HCX5+dnQUdN06KHfDuVZa9mgh4iqXaVRQC8BfZC3VWx19rN0gkTufdqHLLIqeTGfNwUa8r2MdM7dMDoAgkR0zCRbs6efhTt8pDehkSAaRCKPehf9V8egw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b=TVK6E514; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b="TVK6E514"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-853c07a76adso5018949b3a.0
        for <netdev@vger.kernel.org>; Tue, 01 Sep 2026 06:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1788270356; x=1788875156; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xdj2AUGaPiNq53DnFYbYPZcfGTQqFkUTKssFHO7+C6I=;
        b=TVK6E514KEp+V7HbH6qNfDu8lnljqCS1w4RicsbeMpFnrwHmDctfUsdhVex5DqrNFo
         XF3VEX2OQKJ+kqwHwKfExHGYcviEeR2dKEeFoFgdQxriednn2p2IvfpVbu31ekpTjQA6
         k4yrefbKhP8Un096DMpJas7F0QOFgQm1zvgMtlMN5k5knBFb0VuiE0sPWZZWv2/A+iyF
         bkuhukxaAT/+QrwY2cdPwzQBmmKrOR/mD8uW/4sxqIHBkqbyA89LeeQW1jk1UHR4Iehm
         XjpgkKOsUZxVYyVhApZKu59QpT2SKJ/YEdoAKgfXlDuhDygl+cy8GiXWzI82WuFkFm4p
         DFMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788270356; x=1788875156;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xdj2AUGaPiNq53DnFYbYPZcfGTQqFkUTKssFHO7+C6I=;
        b=oc9K2MUPQFa7+xdNACDvrLjJBarg0wWmZLMFsZmu9T5rZDFiaNw41OFExkH7I6Ez1b
         xzGYUb5gtw/mMOKqij8rWJ+pemO7/u54yA21AJYOGWB4EApRtw3mGnTYUPhavGkWiKRB
         7SysQZc1LLewHf9JzE9KRK+wvrHWpTVoXrDnDpXZrN+6aev8sVAqdtpRt4JeYPzW2Epb
         PUBvGmSUtbt78qWU0M4hG747FYTb35ljR0A0gNzcAsrxsrJ5gX9zfRUY/mF9TdpzVPeE
         4ry/rSitaDxxpJpU0fgf7idZa4hdJ5mx+wr/kdSDTaFkqSP5VsDzv52JggNd94q2HBiE
         suMw==
X-Gm-Message-State: AFuF++mo4RmqyR2g0ckHavfp1TrEW6nXRbfHFoAdUGVgdeYYWVcxv/sT
	xTbJroVeQyx5JPqbIbUtSohTX1Nbi4kxbJPlR8QL+uXVkZmN+z9ONf7aIp9a8upIPEQZcd1jjbI
	dqe8+
X-Gm-Gg: AR+sD12uc9F5+gxkfaDRoDIJ/0bj4yQrNT4MWalGRbZMFDejxuQ3P5S6gmxGGJq2yHC
	7KyDWGSsGM42rdgcm5KGJ40RKy9emx54dTrZA/ouYfr8FLizudArlxV/EyrFTTgfggbm3r0OrLy
	WxO2W0QRfspe29TnIjBCcyNZL47b0mmX1EJihwe9y8rvazkmlkBIwGSdboD3VWvll6kLTcSU9m6
	KBSf6WPYuRNTU0BouS+a/iUjLLLfvRnOgcMvC02p6sS69d5T4mqnDAnzV2pR5VXo7biV7PIcGQV
	L0vilp9Rk64yAEDjDHVwhasCA/EgMTpmOyrl//O0NsIPdvPoZd5Tr586LGa1AofLhjk/04P7cxd
	+i1lfboPQ/72r9Pp9YOn/WiN63iww6estS6Esc6qyDu37qje580qrR8ByhjVbV0/u6ZZbTA9dCZ
	zRxZtvaQmGts5Tu1wb6nrrs+JKtTQbHU21MWFaUvluxewiK30MUWcqoXCDuj/MIKqXdYtkSaw0u
	XDGhE6hPQHkv2dJRegVSTe1uCaZVA==
X-Received: by 2002:a05:6a00:3398:b0:845:e8b9:347 with SMTP id d2e1a72fcca58-8562aeaafd9mr55291571b3a.13.1788270349376;
        Tue, 01 Sep 2026 06:45:49 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc1f32f68bdsm6072694a12.3.2026.09.01.06.45.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 06:45:48 -0700 (PDT)
Date: Tue, 1 Sep 2026 06:45:39 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Prabhakar Pujeri <prabhakar.pujeri@dell.com>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH iproute2 1/2] ss: validate sscanf() return value in
 packet_show_line()
Message-ID: <20260901064539.691cb367@phoenix.local>
In-Reply-To: <20260831104116.2190-2-prabhakar.pujeri@dell.com>
References: <20260831104116.2190-1-prabhakar.pujeri@dell.com>
	<20260831104116.2190-2-prabhakar.pujeri@dell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 31 Aug 2026 10:41:15 +0000
Prabhakar Pujeri <prabhakar.pujeri@dell.com> wrote:

> The /proc/net/packet fallback parser never checks the return value of
> sscanf().  On a malformed or truncated line some of the output
> variables (type, prot, iface, state, rq, uid, ino) stay
> uninitialized and garbage values are used both for type based
> filtering and for the printed socket state.
> 
> Require all eight fields to be converted before using the values and
> return -1 on failure, which makes generic_record_read() stop
> processing, the same way tcp_show_line() bails out on a malformed
> /proc/net/tcp line.
> 
> Fixes: aba5acdfdb34 ("(Logical change 1.3)")
> Signed-off-by: Prabhakar Pujeri <prabhakar.pujeri@dell.com>
> ---

Good to check but if kernel gives garbage, kernel is seriously buggy.

I am thinking it would be best to just remove /proc fallback stuff.
It only exists to handle really old systems before netlink diag info
was supported; or embedded hardware kernel configs without netlink diag info.

