Received: from mail-wr2-f34.google.com (mail-wr2-f34.google.com [74.125.225.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52A934D596A
	for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 13:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790773409; cv=none; b=cSiVTTrBxIZBPBb9yZiHPuNdFiK8ldTnxVPcQUhpiGM41lF5MbjQEhLdrBajSICubFk6RiH6ZvmzCM0gj6Ng/JKsAQJcs8VXxPlXRh8RLZg3+0ahMIeoZKqay55+sWnPufF0WhfpeZLn3obHxCPf+bkdmDcvv7P25eMxcOKgsVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790773409; c=relaxed/simple;
	bh=H+DcAKtcxqYbxHPTih+Vv3PnTOLzwij99V2TWd7P1DE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JlsX3Hsvf/wGH+lpnFH5pfGsscnM5P3BqQUnJHXc6qrglcnRIA+U/wPpwoLdDVQ/ILWH777zDjfENoOXyfNzvuMvQd88/RlC2wcI97J0cQ6hPUv8G6Ujo1C+ejk73HLQb8OdMXKG9r9snj5CGDA+08bCvXUQwrZSDJxcildKs0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=MNV4Xz6E; arc=none smtp.client-ip=74.125.225.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="MNV4Xz6E"
Received: by mail-wr2-f34.google.com with SMTP id ffacd0b85a97d-48b01fd0ff1so77312f8f.2
        for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 06:03:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1790773402; x=1791378202; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :content-language:from:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=babN9DRBy5azMYxvib8SKBkZUslU6O5ONocKKc4sKc0=;
        b=MNV4Xz6EaMuv65MQ7JfswBlkewKV/SH3bn7+57KAcGCM4b6ycvIVU3dQ/HbSYg0xeY
         svh1pB1BuZblJ5zblhb7YmW4MrZXqCQhnaoQb+Xr8Qhsb+dmD4lFFiL2szvYtDsFdfPr
         AsIEXGsvT/gRVMP+tVUCVepsk7//eQq253ZoGEUiY4AgUB0W7cHKr932Td+8JKm9fTAa
         1Kgg4HxXiJX60ZLZ44b2/i14X4d6A8M7AUdJZcb1Xbhr+echJSg4HrU6ZCDJOEYKzZ1Z
         9dEoJfC12dbGBEp/m+GJnEGh6o0vJm5uIkp64KH4+pEC94moRP6ttlfwX0Bqv/P7LTYe
         VQWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790773402; x=1791378202;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :content-language:from:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=babN9DRBy5azMYxvib8SKBkZUslU6O5ONocKKc4sKc0=;
        b=bOF8B9dM4tXZPkROvaqYTz8irBLJXECGc4CbYP3Q3olvPNt91M51ikSGBrOfjGW1Qd
         MTTjH7m18ye2GHqg/gBrloCYieI6ix0VF6Fw9mW1LorOBSPM9tnAIfwKou8wHr9El363
         05XFIZRiszbLHB/fP/uNRaAiaxOZqKKQkZVAqiyM8/ooo60Tme+Q6qOyuAU5uuCeDozk
         3lcFksFzdVBuoM47MqQwWofK+2gl7YfsU+/dwVU6gMUKwjh8LpNVau4L1LQorYFyTJ5E
         c/hnbXxpOaP+WqMK3xUT60A1fwVHxI4c99aD+TrGYBzbL1yYcsvHnQaKwDKjru1zKTLX
         u5/Q==
X-Forwarded-Encrypted: i=1; AKwUvBygZiFKOF+m0bgKgy00sK6y+kZXyLpYQzVfK9rkipg32alxpvJgmEOZ2a8dfq8hGckYlZnQY54=@vger.kernel.org
X-Gm-Message-State: AFq9FYKAAihlFt5yWBrG9SugAyqZeeZGO9U2MRxspPOiPne4eV1w55MY
	VNK3kb/jDiafor0c1GOV7gfo8y7f1jAzKRb6runnJPxJz+ciAVsnn0Zmi4QG40QWK0I=
X-Gm-Gg: AYBFou3OXuGP3gh94a7bTLjYOQun1px5rl+pTd4ROtN3KjceJ9iF69fPAtZ1jK6w4eB
	dOAz/bltG9mSWbpmmtBe00J2HnsX8RQDlZu67P0bpmyamTL0i8YmhwKn7dq4oZVSck3I+EG6azA
	McuVWdG/ZJe/rIUYlfOMYmyt5GuOPOXfD+Hh9bJCoq5ywSIlYP3nwkXS4yemdoa8e7OpkpG6ZVL
	aDlUM4bu24eqHfnATMujBoQaTxE6krLa0tFUACKyVG94jX9YECzI9K34DXaww/ZJD16hH23sJgu
	qEHNhT4Rg12RcUby9haeVV+a4fLb/DgYyKFIbmmYp8h0PNGjegDM1KV/EKEhPzkJPzF3WGxQMxD
	Y/CYi3eYRQuOxieGl+O4awfil9f2n3xMFJGom4Am/9WE4wvEzO1BjTVzGZGCyDMUIPIVRJ6rYEV
	cFzrB+wyZNBKabO5xi/TKrrkZPgjO6rpm9qJyny8cdnZ7Xf1RVsWniIe+1PgPM8HHklj1oQEitS
	qDZJSBpEi7E5fARCZ0pE766dADy8Xonu/wsg56cjyMLuxHRe7s=
X-Received: by 2002:a05:6000:18a8:b0:487:342:d145 with SMTP id ffacd0b85a97d-48b0245d2ebmr2617321f8f.2.1790773402155;
        Wed, 30 Sep 2026 06:03:22 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:ab7:2110:6a1d:efff:fe52:1959? ([2a01:e0a:ab7:2110:6a1d:efff:fe52:1959])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48b02a0185asm3461189f8f.32.2026.09.30.06.03.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Sep 2026 06:03:21 -0700 (PDT)
Message-ID: <235a33c2-7138-4815-820d-793568757d95@6wind.com>
Date: Wed, 30 Sep 2026 15:03:20 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH net-next v9 2/6] net: change netdev_hw_addr_list count
 through helpers
To: Yuyang Huang <sigefriedhyy@gmail.com>
Cc: Ajay Singh <ajay.kathat@microchip.com>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
 Donald Hunter <donald.hunter@gmail.com>, Eric Dumazet <edumazet@google.com>,
 Ido Schimmel <idosch@nvidia.com>, Jacob Keller <jacob.e.keller@intel.com>,
 Jakub Kicinski <kuba@kernel.org>, Johannes Berg <johannes@sipsolutions.net>,
 Kees Cook <kees@kernel.org>, Kory Maincent <kory.maincent@bootlin.com>,
 Kuniyuki Iwashima <kuniyu@google.com>,
 Nikolaos Gkarlis <nickgarlis@gmail.com>, Paolo Abeni <pabeni@redhat.com>,
 Sabrina Dubroca <sd@queasysnail.net>, Shuah Khan <shuah@kernel.org>,
 Simon Horman <horms@kernel.org>, Stanislav Fomichev <sdf.kernel@gmail.com>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Willem de Bruijn <willemb@google.com>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-wireless@vger.kernel.org,
 netdev@vger.kernel.org
References: <20260930112842.21323-1-sigefriedhyy@gmail.com>
 <20260930112842.21323-3-sigefriedhyy@gmail.com>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Content-Language: en-US
Organization: 6WIND
In-Reply-To: <20260930112842.21323-3-sigefriedhyy@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Le 30/09/2026 à 13:28, Yuyang Huang a écrit :
> The count of a netdev_hw_addr_list is changed in several places of
> dev_addr_lists.c and a few drivers read it directly. The next patch
> needs to account every change of the count of dev->mc.
> 
> Add __hw_addr_count_add(), __hw_addr_count_inc(), __hw_addr_count_dec()
> and __hw_addr_count_reset(), use them for every change of the count
> and rename the field to _count so that a direct write stands out.
> Readers keep using netdev_hw_addr_list_count() and the netdev_uc_count()
> and netdev_mc_count() helpers, the few that read the field directly
> are converted. No functional change.
> 
> Signed-off-by: Yuyang Huang <sigefriedhyy@gmail.com>
Reviewed-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>

If you respin a version, you can use netdev_hw_addr_list_count() in
__hw_addr_list_snapshot() also.

Thanks,
Nicolas
