Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EE011A01BE
	for <netdev@vger.kernel.org>; Wed, 15 Apr 2026 02:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776220326; cv=none; b=IGgLiWqPABCs17K630c78jxqPXWgMjQLCK+ZPk9pw1P1tYzn18BYaupvdE0hoGGFAS3IRmLkCfoOaGm6OYM1dQNVrOeC1kaaCE80BIC4BkD2UK31PVEf8uAXP87xZBPxnWjlAGIapNU1rcRqMyDEjgbOOytyFRXCJNwzTupwqao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776220326; c=relaxed/simple;
	bh=XC7skam8ubw6gV0ii6HbJJLjnVzjbkMM5Cx6sIU8Uk0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ese/xGENUWYkL06HqNzLdRhl+bGJQhwGPtyXya/5Pndu7Q7AJUzykdKMlqElXCbYY8r1LNK+DT1JdF/LsgzcnFLH1TZrFxEgGa2dnmdjOGTS4W7N9YTL/s2SweWwzzUt9O32je228qhIzaGTO44UgkYwhhIQk3qQfHDVgIwCdFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HHlHzMlo; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HHlHzMlo"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2a871daa98fso40564335ad.1
        for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 19:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776220325; x=1776825125; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5ko95VK2cVpW32c+NVOFxUmpwNqHrxP1Yef06OW294Q=;
        b=HHlHzMlox6OWuqg9E3125ToZNNy0b+1udtLGTXtq8w/vt8FEQGKHUzBWukIisql080
         FHQJg1HLflYw01495Y6f1WDbHYGKbnqsGP6UZjZUmBhUORVX6+v1d+Z58uHuI90YT89Z
         vjh4wFnHAtoUtFbKjgg2GCme6H3lVI84HYIFW+codYXPgTL7By43MaSuOilkQMskNg6A
         8E8/yJIoYxGXvQriXXRpTcVkSs1rNf8AzITCFaK85Bn81A+jTPfaTXfnroas6xPmRPrc
         CfJ0Nvr8dU8W0e76O4wcIFlLQIwZ6AQTIlhsxlZ8WZ3scAPNVY90D6pgSvIf/3+lXfes
         S0Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776220325; x=1776825125;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5ko95VK2cVpW32c+NVOFxUmpwNqHrxP1Yef06OW294Q=;
        b=lgQ2INh77oHe3zXs54Z9OlRpr6gi6w9TbdTBsQkIBz2Dpuh6lHKIg6sI+stn+Z/hST
         OZM//lja14mgpQnBFnCECb7TGF3KpGCjvTeKrfV9NL+wBxLWg5YE9uBsXAH3Jawl1s+E
         ZteH/kiSGGf6Z+wKNNSpr2kgZ+6knRZq3kAOWsCggH4Ut9jtGwKzv7TThSZ7gK3OeZ+O
         txheykDppIsyFpTwJEdHKxEWDb1rd/WbzqFF2CjLoW/1NjGsbQavBimwWHtIdvxOAmo1
         SNN5xLx87D76F2+8uCM956yFnLKVsF5JZfJPzOMNZZMCkQ1/5x9yVMGnUAFsVNRAYK47
         fwrQ==
X-Forwarded-Encrypted: i=1; AFNElJ+Vti3PXTk3rqcOBCkImJ9l/UtCG42UrAFUNPd9i83mOpfxM+ncY8THWUDJzcOoMwEPXhxAqWo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRGVfeDJTlUgOeZuOQ7XIU92bbVad2WIkCZX1KvVIcLshJQeCA
	X9eSyXO8ubo6Yvpv6jE/Bz50I1bc1gUkmVNzYr8JU5YC3GF5DhjfLCjoYo08ZftbUxdPwA==
X-Gm-Gg: AeBDieu1xGdWX/QQHGRlV8Qhw+K8zrnivHw/huWxXui89sUEyNvmPazktkB6akA4cT0
	7xk0/loaYPxSdnNIMWtmm72atDiHTJUZvVSlP8eGvDdIqRli3paquC+PQhATuOp0JGblXYvme3n
	DpzESQy0lmULuykOL2CbvlxAEC1midZzD9SmQYrQd9MqjKKwcFBKEV1NdkYYW3/OOnxjqYolhTe
	3J6OJCL+1gcQZEEXDPm9LFE6tjvcr+MIjUqS1aBvnDjQ1/vw0C8gZZVDN0HvYI+jgra9IN+SvC6
	qzRSx22sUiwRVic3xdJU16dWGQpD90JuqZbRY5LE8xUYVnnM2nfjr2Wqh+5qt5Bw5gkkZLdADTG
	7q8N6ce8IlkiVHlFi4F4RwBsVLf/EgdFMt4eZLlULkKrVebv05i/2f2RjGu1JyFBwsgJ6RpWO7e
	7ZJQ/fSch6jWM/DBv+hnX/oPfimuYi2nub
X-Received: by 2002:a17:903:acf:b0:2ae:ce35:2686 with SMTP id d9443c01a7336-2b2d59393fcmr203681075ad.5.1776220324688;
        Tue, 14 Apr 2026 19:32:04 -0700 (PDT)
Received: from localhost.localdomain ([180.167.178.215])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b478142565sm3379635ad.37.2026.04.14.19.32.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 19:32:04 -0700 (PDT)
From: veritas501 <hxzene@gmail.com>
To: horms@kernel.org
Cc: chia-yu.chang@nokia-bell-labs.com,
	jhs@mojatatu.com,
	jiri@resnulli.us,
	davem@davemloft.net,
	edumazet@google.com,
	hxzene@gmail.com,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com
Subject: Re: [PATCH] net/sched: sch_dualpi2: fix NULL pointer dereference in dualpi2_change()
Date: Wed, 15 Apr 2026 10:31:58 +0800
Message-ID: <20260414160000.1@hxzene.gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260414183601.GD772670@horms.kernel.org>
References: <20260413075740.1@hxzene.gmail.com> <20260414183132.GC772670@horms.kernel.org> <20260414183601.GD772670@horms.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Kito Xu (veritas501)" <hxzene@gmail.com>

Hi Simon,

Thanks for the review and for pointing out the alternative patch
from Chia-Yu. I agree that the more comprehensive fix is the better
choice for this code path.

Since I independently discovered and reported this issue, would it
be possible to add a Reported-by tag to Chia-Yu's patch?

    Reported-by: "Kito Xu (veritas501)" <hxzene@gmail.com>

Either way, thanks for handling this!

Best regards,
Kito
