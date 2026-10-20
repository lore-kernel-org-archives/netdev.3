Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=209.85.161.41
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1792493041;
	b=r1Td1idwPf+TGK8IhCO5PRLQoBaSRbQiKRPMZzYmqec9/4iLYTnX4eoPiu0RX1W0mfOr
	 QtNHe3WCrfFLx78XK1qaLaNG+uNXS/DGA9Zo5g9hgH8jFPD9tFtamgdtAMsaebwLkdPIa
	 pg6DKZDEjYk9Uopq46o39dlIquzYxPG7kM4Qw9eL7OEE3U2ctcT725sxZImP9tUe+ytYA
	 6uQEIgFxCzDpEY5qUqCXKsdkeQNi5cXV4jzjB8G6R8hn539TiCFbf8fo7siraZ4Eu23MS
	 rKO2FrBd8WgtPBAOw6CLgs+2DYrzIpJAGFdk+UHWusm3/HvL+y0zbb+T4Shpw6jqOqA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792493041;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=kqXlGHZK1pUqa9HpkjKcxAViOyKcyPiOJa87b6dOxE8=;
	b=lm8b3aBT7QNQQQVN1du3IrMYXNHZuJ29BvbHWP6pay+vZ0fLNCMF4i/YcEmupfDNgGwf
	 6LFg9ZaeSllXfSAsEWMiuvTybom0uMu7XMFRNIi7AMr+6wv6Im8FG67qHS+T3itk6rEzP
	 unEAouscrSj1WX0Mff93+4Jcu6rsslJU2CQbdmO4UtsA4FWLzHf0V5peP3d03MfX/8et1
	 gjpi2FL4Vx5jfOc6DvvMt2+AhuoONewh4b4TXAtGOl68YavGMQP99VPn9R740f71tbiQM
	 eOQI52Nf7lTAlZAEP6x1gnUJJIgaPa7N/beQH+L6OwqauSsTfLFHeYZZBRHlGUhpxuA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=RV6keQhY;
	arc=fail smtp.remote-ip=209.85.161.41
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3B90606A31E
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 10:44:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E3B90606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=RV6keQhY
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-6de1ca1b05aso2215416eaf.0
        for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 03:44:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792493040; cv=none;
        d=google.com; s=arc-20260327;
        b=BRHIogWrL0fsWc3KHYU5zZSNnFeyijyBJeca5BsY9fDmbwY3sP/z7MfiXSSaqToI/t
         uwHnRX54eBaQ4rmV2PgjrKLI3fgKXNnoGuuqKz04K+8aFUq3F8P5iAp4J+oXJYoQj3Ts
         LEZxuXlZbUwPwHVg6LqaCn1w7Xe8LASsPO7cxPFnFx6QN0LTbEEFGKLUs7CZceUVHEVU
         arZ7OkrpjYI0fVaEiyB/lYyiK1cu1kG7usui7ZL1xAJzeUU08p1lYDE3611GA0puVdzp
         mmDr9xJBQl3Aa6Vc1dOvb3sET09h2CzoswNCMkEafVEWK1Lagj1o9HDVOtEqDxleUhMi
         RROg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=kqXlGHZK1pUqa9HpkjKcxAViOyKcyPiOJa87b6dOxE8=;
        fh=JjqfQWI+R8KiP8dlvehGwQ74O1pa/OBTC1JHmM0snzQ=;
        b=Q8cnJ5dQtEu9X1QEnMx+aQBCCv512U+qvdX71X7eDxgspaHNformF91h+mpvBUjAR6
         6/+sTFJF0b9r3+8kZP1+BZefoGxPneMsO1qB88DvPYH+L1UOt/2rL3oT9ibucuhHUzdI
         2ptt7X0UxewM+KCasCTMfVsDyjMSIjeiKOMsUZ1A5YYUdg8RluFx9cn9OVNmFAzZ8DrB
         eYN94CfSgOl5Tgo39IueIKF6JZdMINydr/vANtENAi/5v/DdJVOL2xzokXO0dysXO+vm
         jGOhltK9KL1hSfeQXiON0ZrUU9aTVTuRthmq7NHIAcisABbi28kY5o2jyl5BqB73XjOD
         zwOQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792493040; x=1793097840; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kqXlGHZK1pUqa9HpkjKcxAViOyKcyPiOJa87b6dOxE8=;
        b=RV6keQhYLZFKssPsWpA4J+SY4gQ8BJ6VCOIfVR6UTl4ZnQQJwqf3k3KMLqmxu5pEEs
         s1TfRAzYuBgXl/aLRTxQkJJxv3y9VzWb+Q8C9vFsD9ehMBhWPQjtMwUlStCsis745mex
         j5K3attOH7+XhCVf49Ap64Eht3YCGFRXc/i4G5/P3PKpHMhD5hDL84oZ5T/i1lTTDTbU
         cHo5sF87hWgDgV++9fWTyk0j1WsGGMRCBWoMqu05FfZD1KcJULMiZIhsE5kIxV6E0lYp
         nIdWW5byDkVLOjCcZ0z2HvCvSzzDyL9VvtdVFeR0chdt1NXkVxV7dfFkY+KZcpblx2Fs
         ulUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792493040; x=1793097840;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=kqXlGHZK1pUqa9HpkjKcxAViOyKcyPiOJa87b6dOxE8=;
        b=lHlQxG0fDOx59IYsmXwNBvybHfE3FTRw1XwfALnIjWbxGmD7Xd11QYK/30t3el9vCn
         7v/YrvHM1zJVW0lzNhzw5P6kFYevLfhp9HtMs2MlN7bRJbGa2m+YM8iQFwzpbP5xq/cG
         wIL98u4XzfvH82dqyt/PVdVgduso1v1O56H8Kwp8vwidRmYPGjZzVP0ZO/v0QCQSVq/u
         ck2/opbmXAhRwnxIhmtarU4wQexoxZ04DG0/iyoLG4hq/EiI/Uptz0iMrS29EfwUtOiC
         ZlBpNC7RsYF8cptJpzRQgfsXJqNlbyVySH9/S9X66g1arbGuQpsfvkcjNXS0/PnQjlAB
         VGAA==
X-Forwarded-Encrypted: i=1; AKwUvBzQmwUa/hHO+hgY3XWOLsso+l5RjhI+0QQtNJqft7YxHwI+KcicorqntH6ZQGb9OyBQqVd9zzM=@vger.kernel.org
X-Gm-Message-State: AFq9FYKVafOOgjmUyxSdeQep8Zjvkm1TIEUJsx/aqAh1i6pR2otqd+ZI
	krOND1YCHHayw4l7Tcrlb3JyR3N7mQsKXj5UFhKF2GQl7WCc/ffG9q1n+odgA/6g9TCY7L0UEx+
	qBsMhBQYffTgTaO9Ieo42K5Kct9hztvc=
X-Gm-Gg: AYBFou3IH04mzYLCgYXsL96chiFXB/JbL3/z3ZkrnOQER+eUuWwIZtMyoaX2mMhmYoy
	KvVTLJtZghyr8+7z1EJFpIvTh+N0Z3QnaHa7oS+H3t4xM+62L7sgvqouV6vFQ2lpwO1HQ80pXWM
	Y0Wjju3UKjQxmumhgJKy4oWvhuIf3NOr/7A1cAlzO5HX1z70FxhN6FpGRRVxXLJhutNNy/Xg9My
	Srf3WwFhyJFWDVTBRMbzq3a6ojuG37wec1Enf8h61FO/8ptOIwSng5cfIYkid1UMn7eWlAnIOdX
	2wILk1KjTbKjgAJ02VF8WWLc7+uxGJqYfLbTYdsHWwItiOxes3LS1hhR8FN0fL5CF8dtTDooP5B
	RjqgKQAfy4v5ueS/WynGZFj7WQSy3rFnzBV+zzoCAZKqb+GIkpAs+pKB0JC6gS9JY6JuO9YVRnh
	JD47uitioZIbCUTK9PhTA5SCNmkYKhe2ECHz+TolFsMv+/0daVczHM
X-Received: by 2002:a05:6820:60b:b0:6c4:50e0:4e0 with SMTP id
 006d021491bc7-70356492b06mr7440160eaf.32.1792493039924; Tue, 20 Oct 2026
 03:43:59 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <CAFcZKTyCu7K=1OOETBvVrKf-9YKHRk7wXNRyZW7m5P0PEPg1zQ@mail.gmail.com>
In-Reply-To: <CAFcZKTyCu7K=1OOETBvVrKf-9YKHRk7wXNRyZW7m5P0PEPg1zQ@mail.gmail.com>
From: Peter Morrow <pdmorrow@gmail.com>
Date: Tue, 20 Oct 2026 11:43:49 +0100
X-Gm-Features: AclHuK_ZTJZ-MG-SKAI7eH3l_zmO7EZx-WhALvbMgrcFjsGx7J0OsMIcUbiXYiM
Message-ID: <CAFcZKTzkDzPXpjFqU8c3rpY3R_FpD_tWRu=PPtkar_LCn1AsxQ@mail.gmail.com>
Subject: Re: mlx4: no ib device for Ethernet ports without IBoE since v6.6
To: tariqt@nvidia.com
Cc: petr.pavlu@suse.com, yishaih@nvidia.com, leon@kernel.org, 
	netdev@vger.kernel.org, linux-rdma@vger.kernel.org, 
	regressions@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

#regzbot ^introduced: 7d22b1cb9d84
