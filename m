Received: from mail-vs2-f43.google.com (mail-vs2-f43.google.com [74.125.227.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72F4D3E00A5
	for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 11:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789384152; cv=none; b=ogXgZ19ApWmJ0r5NeT31TquxPIWjouYh3ziR23iorr0yd0koCO8hD7fl5Z/CRZ/CBn9673V/rIRu5If1t5wO7lJzQsT89wf9HmBDez+mK11RNfSQXs2r2vPCeiaAloSz17X5znYaW8bLxvJk3SI2TMECeHoshzHbTKxh4P7AOVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789384152; c=relaxed/simple;
	bh=cnTUXTL+vStDgG+NMGmRCGSw2eobuM+C7j2kYz4fpJs=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=I2oEm5EIDnCjYdWBcoyz8Fx55Can5sixGDe4w+/dEU+ztPReqagKASUVunFZzTqfdsA9rP9oOYzf9RIJ0OcdR5v6ZJRBw8oKhm/JLB0HGrTdkC06raXiIp3LHyVTACEnAc3hbGZV7t59BcquIW/v0gFDlbrXM6onYARK535dxiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lsRTb7pp; arc=none smtp.client-ip=74.125.227.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lsRTb7pp"
Received: by mail-vs2-f43.google.com with SMTP id ada2fe7eead31-78a7003f94fso310588137.2
        for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 04:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789384149; x=1789988949; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=pSenaxNrN7Rpor0LAgOLds9XDBBj6mKAJnNQjXr1NB8=;
        b=lsRTb7pp2cjQ1AOqFo+Nq4HsHXy28wVwmrtX4ghkJODXlKpeVQLcy7lWa0qr4Imtif
         WFfLCn+ORY5JAS6/d9w9sWsT+hg/TeL2NlJHCruM7NL8EAYY4FDB7SXAHV+gXmuBEq76
         0HTbQfrGxAfpXEHsbgU3WQRJ1v3n3wzkgU/kh2c3vqaEA20yKXOSVM6Zt15PRxxa6PdM
         i1QagUkIAom5mCNEJ1F4K9AG5oKMpMMcFnTI/eNI/d6oXtlsLxzcZ9shIMOtzTQw2HWm
         sWC5N39t0eI+a/Qxm82vULpM3krVknDJewt+Epu/8S42aZglHxKzb4+MR00PQrW7ziV9
         HOfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789384149; x=1789988949;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pSenaxNrN7Rpor0LAgOLds9XDBBj6mKAJnNQjXr1NB8=;
        b=Jj/TI627owmvA6auS1BADkEsNNgX8c9jaKA01/KwcneV296PNQ2tH6nq++F2HiQJ0C
         ZbnykqUgmesyGm1HrpcsBlwFBYyqeYrBwQYMYbDnRhutJr//wmGLKh3shdC/1FJpp1XN
         cr9Yv6rqP/VQ3kVpseSzsqeNTJq6qdPWankhTwnK1n9goOYdWNCiMSTdU3NxmUSEQWNi
         mtHj26J0gG3DQsbofxHLS+2QNyNp4Xv1s/soF5m9l3bbtt2N2cY07thCZbii1KKnKxzV
         iKbLi7UOCfXveNhkZ2y74uGIxA0ziCJxt9cMREitGzNccQWGUv+gKb9jkppLnNELOOMR
         asCw==
X-Gm-Message-State: AFuF++n/fVARlduNbNy8DY60ev1VdrU9UYc/ZCLu1gQSfQe6X9kXGZLt
	D9+nF9Yvxx1/1jMz+P+jgnf1KsXgk6z84CKER872VjX3FaET5dEZ1uRP
X-Gm-Gg: AYBFou2F2RK0Py/qWElZ9pfd7P/w9JTBntPJgAh/+RxhyiunZtX4WQxWXBF5DQNHiJ2
	PlLR6bU3LP3fNB52kqDBdfX3nQSfQnKBbzHkun7H+GQcbk3GX7l143QMbpRf2UuMhVq4poVYa8I
	VLwn9YjpXoeTaAQ+YhbeF9XPkFRqPyHrqFigF7bCZuvl3UKP9AGtSddLaZAaFa3g//04J3W3j5q
	Z0UIh9TOHmbLFnMxskFx7bTxjg0rY0WUSb+Q+dXk4fJwXT1AJ5cV5IxvNWuVLb5/R4op4NxhrQG
	onaNB3uEOKIfXIpsz6GHGv3sPUCLWWpkPg+sl35KdokBRaHqeRrTtckWRzopaSjtwOaEUCLz1yH
	0EKwGl4PdJiVFF5MGZwDxnuRsjN2g1G9Oz/o7uWrYUIb2aMiFdDmCtARiHIsAwVAyg6UDrh3y13
	vjF7TGc66gW2AGQLoYCpdQlk94Zpa7x1JVC+ag/OoVtMXNl7hZLp2k/ueYn/s3JUS1tXe+q8S0n
	UuGWaQlSHvDbCc=
X-Received: by 2002:a05:6102:54a9:b0:798:8ca:3452 with SMTP id ada2fe7eead31-79b58398adbmr777052137.1.1789384144530;
        Mon, 14 Sep 2026 04:09:04 -0700 (PDT)
Received: from localhost ([2600:4040:9399:4000:e553:72e5:7d37:c7ef])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9121a62b783sm73606186d6.23.2026.09.14.04.09.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Sep 2026 04:09:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 14 Sep 2026 07:09:00 -0400
Message-Id: <DLEZQLZQJ93Y.3UMMAGWW10151@gmail.com>
To: "Jakub Kicinski" <kuba@kernel.org>, <davem@davemloft.net>
Cc: <netdev@vger.kernel.org>, <edumazet@google.com>, <pabeni@redhat.com>,
 <andrew+netdev@lunn.ch>, <horms@kernel.org>, <daniel.zahka@gmail.com>,
 <willemdebruijn.kernel@gmail.com>, <donald.hunter@gmail.com>,
 <shuah@kernel.org>, <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH net-next 1/6] selftests: drv-net: psp: fix linter issues
From: "Daniel Zahka" <daniel.zahka@gmail.com>
X-Mailer: aerc 0.21.0-threadmapfix
References: <20260912200426.121025-1-kuba@kernel.org>
 <20260912200426.121025-2-kuba@kernel.org>
In-Reply-To: <20260912200426.121025-2-kuba@kernel.org>

On Sat Sep 12, 2026 at 4:04 PM EDT, Jakub Kicinski wrote:
> Fix ruff 0.16 warnings:
>
>   C403 Unnecessary list comprehension (rewrite as a set comprehension)
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---

Reviewed-by: Daniel Zahka <daniel.zahka@gmail.com>
