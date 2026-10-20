Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.53
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792479300;
	b=r/Z2gXlOswY3de6gB51oNSMRYGU1HJCRTz5LauYql2Sjmvh3Od2hVSuvMsOaWfjqbRcB
	 T5I8K9G/3G+C9GYN+8Ho2uRovqGzS/eUPbbyUyYbJLN51UidPzC04Q9wxeID08xi0Wtm7
	 kBJIq0FRNt36p/zYxHfiXEY9gKp4dwCsWHSPSlSWlkGYbjWTwzl/jhYTaA714+9HjP/vr
	 9DbioSd7So8rhSTj+T49DgUaHMrxlEmUDGxRBz987ydpdm9iYrDFltxjkCEWuOd8/guYM
	 PSNKMRGpsqZzCTcFDnx7CSnTmGdjNxVA1gDsFl1/tctLXqB21dsXVhHuJBolQ9ItlXw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792479300;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=9ld9jL0DTken0gqzxn2ucRjCv5d/jWcHIG5inFHe5XA=;
	b=V1ktjNBmouojMsqRg28bKTzqjKbI55VpU9vXJOHPr8rii0/NXlwzdeImCXVojH96BjE6
	 eT1vkOnKlF8bMHgP5KNdbXq3v1GVDLr+qYuLx72LMkb1UgV9aV7YPGOcX9v5HRWv0BhV2
	 G4tuXYTIzd03NbnEncxx1JfHXeE2zJKoFWaJGJFTinA+WHKe8l32+Vg8b5Ycn0fnpJJut
	 J5F9RmFbYq69udXTN6kyzY+oM9ccbY4V/IdVxHZXtEExSS4KLEx97aV1WBndawU2w1ztA
	 wyG5QMn/EvMyxLI7uoarXf6hGrh7oOtSAbwmtreErmzgrujxtija5S7BBUk+ozutrRw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="IMgT/bsm";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.53
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9433606A31F
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 06:54:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D9433606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=IMgT/bsm
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-48bbb06e746so1430373f8f.3
        for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 23:54:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792479298; cv=none;
        d=google.com; s=arc-20260327;
        b=j7PJkzRjFTFuy4bGeJIMCimXEG2K/r2Z/+ozNvf3m/tYa5/LfqQZKbdrG5NgOvccnx
         O7tCNDPSxPlj9nDf6JVIDRHT7qs6s9pPz7LjR5yBkueiXLZ5e1wohwHwoUcc/D2Zbvct
         cF09kNKMvYKG1v/Dkp4f+7wT2qBNVLVl1DZxbyhU2S9Xm/3fySKBkVsKBM+1ClameS7v
         /3CuuFwFWE9gomdt3DiczrOYLOcMebV+jl9lHJiwYQn5eI+xmgJ7bB//6tVGdeQnfAC4
         J6/iU/rAkGdL7SRv8aQQb/fCQJ/AJsg64l8ovd2bo/HQ50rPps9WihRJZal9pKADxBPs
         GzRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=9ld9jL0DTken0gqzxn2ucRjCv5d/jWcHIG5inFHe5XA=;
        fh=8rd+TCdgteqtvv7KFWPfv+bvov/zhTwrQj70gHuxJsc=;
        b=qsTIm7sFJU8nNTOvmF0EiS7YOdjm0DglQ6i8Q28haIU2v3bwOlRsZdbGIVwRQd590N
         eaHpdHwd1I+M2Mm4kuMgwJTMpEc29PDA6hSkZJbfMfVqIPeuFPmJjHZP+vRzWW0bFR+5
         MQQFy426jAF73ujHT/hx74dbdiRvVyHgJHHtJyfMrsNxQiLTYy5CAds2bFsnQgz4BmwA
         Z1Va5fI9m8SmuQOB/LDeQVUo4NloOK4B+Kvx3jA0OdnSWyoViKerKka1QhdYXhYjrVAB
         yuX9NHwlY9gsBLCYDDJfSO1rmL3UWutfrrV+uUUKyuVBzK9U8DnVf4H8eNH4VZkgQG+F
         GEGQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792479298; x=1793084098; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9ld9jL0DTken0gqzxn2ucRjCv5d/jWcHIG5inFHe5XA=;
        b=IMgT/bsmwHQjBY9wVPzc+O2aY2wzalSMejfFvZGc2QkJ4ZaGTmiTLC/0Gz7oStr3r0
         wxBrGLzDDIxX9pp7dd+EjjV074V3DU/CU/MyNH0oCKofyOjjGrA2eSAyzB2LmOV18NIc
         gQGGoHedexwhj0Cro0OLj/SlqEBvt5Ck5CKx/8HpRmL47c2hytqjVXQnq9uK2AaLhOxv
         WjjuEvtLyWkvlU9rV/3biBA9xrOFSZt+JbuIJWAaTnwBeBTsPMS0dj70CwJOwtdXrhTD
         EZZ61m2u6xpndHZOYIltxHQrEiCb8SdNzT+z6LDsAB5XVpu79ReFJkAeuqvh+h8HUDlg
         ycdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792479298; x=1793084098;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=9ld9jL0DTken0gqzxn2ucRjCv5d/jWcHIG5inFHe5XA=;
        b=lcdP/2NS6vzREZfFAegOxObpptb9FNK1lhcvsCB7uX7+uVN5YI8RMpzprk8l9GTMk4
         ZtKxHhM6yCh2V9RzQVY0aJrpWo0HDg63QbVHXuj5hThCxmW8LChymInmgF+HXe7U6MPl
         E2Pz6Y5OBKsS+BKl0KMUHYm6hwSHXvt3FzttuxJqPH8CU/FLeSDhdHPdI4q2VIpkQrWz
         AEc0ZScwZJJ9yvrgZRO+21zB/ulC4xU9PJxezisQJl6EvSMQwKGOLapRauxRlId8/zXQ
         0g48XoZ8eROKeDoVvuoDuX4rttVSqWV5SzX3Sg0HzZ3Mxw+t7A4349sxQnuO5ytBT4lW
         KLoQ==
X-Forwarded-Encrypted: i=1; AKwUvBx4KL33wD6GKlXYinfIzxx+HJlSeHJ4D2WyvY1IlGUSc+kVA/096MUHu7IxveBpBy6gDzyJ+9Q=@vger.kernel.org
X-Gm-Message-State: AFq9FYLrkbUOtu3nCutGWJ+7HfBSFnfZi46Ec+MCbb+k8zxXbOH7iFCl
	/z/1B/sxHKy654N7Bkbu6bO3TNyWN08I4SQqWUGfsm2uzeo5HD4tjFZvLiBpHZM0du9iIr4fFrd
	mPWhr6gPp8uUr8wAlyqJ39XqNfZLAXZ0=
X-Gm-Gg: AYBFou1Y0e0HhiaBfNJbRG3j1eMeyufZJi+As6UIgX3d6HSZSHqZl3i8YTBOeO/561F
	T1X7rXXH8TYXjqLVX+jLuK2+jJjL7AxRd/uVYazqolYIOpm5v70LqmSL5UbTX3GmrY+XmnSV9U2
	E1F8VLLTjH2yvqzxXtnWGac43x6c/DlIu6Gtu3Y0wQCodxpIV5D6q8zSo3sQkkKFz6jWpIoO+/X
	d9YkxZdXeRO/+PfSFprnCrxtSRcPGJWJwg9fQSZBleEx95CDogyFhjzBgVwcgv3s+Slgaq+B3h5
	EDJdMdZoD775667Ate6Lsd/iCf1WXDThbgv1nyAlusWerbsubz+OZMs=
X-Received: by 2002:a05:6000:4287:b0:48e:f07:160e with SMTP id
 ffacd0b85a97d-48e0f071653mr14185722f8f.38.1792479297921; Mon, 19 Oct 2026
 23:54:57 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20260920165057.3753458-1-maoyixie.tju@gmail.com> <20261019151322.8175-1-chandru.gopi.dev@gmail.com>
In-Reply-To: <20261019151322.8175-1-chandru.gopi.dev@gmail.com>
From: Maoyi Xie <maoyixie.tju@gmail.com>
Date: Tue, 20 Oct 2026 14:54:46 +0800
X-Gm-Features: AclHuK8JifTJKHboXY-hs4VNAOnYZZ8jD2r4TOVYfzu6ntoqa-h5dqwxPXYyvTk
Message-ID: <CAHPEe=FsFgZCv7v7oeVopR9JFH0ONpPH14O7g_Rg9uUcYQw+Kg@mail.gmail.com>
Subject: Re: nl802154: GET_WPAN_PHY dump resolves NL802154_ATTR_IFINDEX in init_net
To: Chandru Gopi <chandru.gopi.dev@gmail.com>
Cc: alex.aring@gmail.com, linux-wpan@vger.kernel.org, 
	miquel.raynal@bootlin.com, netdev@vger.kernel.org, stefan@datenfreihafen.org
Content-Type: text/plain; charset="UTF-8"

Thanks for reproducing it and testing the change. I have sent the patch:

https://lore.kernel.org/all/20261020065125.896530-1-maoyixie.tju@gmail.com/

If you like, a Tested-by on that thread would help.

Thanks,
Maoyi
