Received: from mail-ej2-f43.google.com (mail-ej2-f43.google.com [74.125.228.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0D4F41A502
	for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 21:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790803431; cv=none; b=YGRY6oScLXRasUu7Z7n7HAV0jt/2jLl6YZmyJ8tU4562YItpleB7SDJivrjUWnOmVfU3g08L3gfjAVnZQWG0vnRDW+sP62j+l7tp8DI0i+rehyoIuF0mzutOc0hd6h/MIHuXluJLjPS25M3ln4dr5Qkoc55WGJeJvLJbMRiwcKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790803431; c=relaxed/simple;
	bh=5nULokajq+EGRczUFAS/zID2IRCv4L5cJMxnamASDig=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j3sRXkuikadNpMVeaec1JAySkjhwW50Eve/aJSDQ6kW2SXG308OylUeXZtIruVth24v0asTXgkjJLkG5m4x7LppdP+3ar0hGpgUrD730Jbroht4tUVZjcl2Ku5LyXQ8nP/W/FMGx2jqk34ThZne52fkW/xNlPb0uXonbTzG6zik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IoRnuKPq; arc=none smtp.client-ip=74.125.228.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IoRnuKPq"
Received: by mail-ej2-f43.google.com with SMTP id a640c23a62f3a-c2af7721e4aso890556966b.1
        for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 14:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790803428; x=1791408228; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5nULokajq+EGRczUFAS/zID2IRCv4L5cJMxnamASDig=;
        b=IoRnuKPqlVsp/Yv0p8kdYuFBoIWbuRUlQdX3kDAIlgGtfRUPkzpP3xza9IqxtiJ4Ud
         6fyCNAGd87Yl5ZAlXguhR8q9lg5qL7UHuHSmmx2QWX4AURrdcbT5HTSElujM7Fmwh6DW
         UuQoZg7Z4qxL2D2gekKuakPIclrV9V5A+2hLwiVEy6Lf7XPGE8gkaiv1ZTzODTypD8LP
         li60Gug9Iy0fG+k6dWN4COoqAlEHmCoujVH3tNhj7VuoJ/A2Nj1NEBVvYDcIUYDfahAt
         fKt+jFauN1Q4HPKEl+xS7gv+WQm0/115ikVGHl+d+ckEDbMsSEIdnmHDdU7iOf/q4YIZ
         2YVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790803428; x=1791408228;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=5nULokajq+EGRczUFAS/zID2IRCv4L5cJMxnamASDig=;
        b=qsK3hJDB9HU4IswfcJKATA1Zr+gMmrr/cEWC/yICI93XfcqAISE8PwjU7MQcg16sob
         T3rwLVRHf3RojNQRDRlcm3mt2VFvAFdi3dK0rTB5nIi2aL3Ev8eB5Oc/M5e7yML7bsEB
         6z1dd8VcT6NQCRXFoFZ9ZWn0WeUUjgilGQkLX1d7hpj0QjoQYS+MFF+S9VDhs+Q21ROk
         QiPruGz0uHRxMmA7pco8T+K6M/CIGiesJXleg/UzHIEikZHRp8pUlKY5BJAgCo+IlRYv
         jcc3kNf7nv8rCUFqC8FQfl4r8hPtPxKVQXB2nK2yVsIaTWRWZBjy1yObxQDxVzFeHw7z
         UqiA==
X-Forwarded-Encrypted: i=1; AKwUvBy2JBYnVcfhuebWuAosj/m7OVW7nBv6Lyzw3RhCJEtAxh1uz3edccc0ZwOUwoku66Vuxhf7Lt4=@vger.kernel.org
X-Gm-Message-State: AFq9FYIOlFBnxqRyC/4nNlaQudqny2Jt6Pl1D29uYUdeTvuJcn5sea3P
	W1Il9e9YTNO39hJT3Lo54qbKe9ZcDt54+pn0SfXngCqX5fliCFbLIM4U
X-Gm-Gg: AYBFou1YihMAZFUfd4IZJhgKIl/JQJB0efCxUzLCZ9fECbSezdEvoEhDbn7iM6TVDtE
	IDwvSU9ji6Y27PnUG4UM1fyFxHTroZP2MVa8mQUtaV0WDqC2eqbCzpp3IFaKofxetZCVysKQLoK
	oPcOSXLCjTpVyogPZOfNx3BhRMlAjWK4TNTR5MVAVNb+1YAKrQao7J9Qu89tmwavABxgECZiAxA
	5SYjrMCc5naRCHpKixZebs9pUhZglVSAS5V36a1AnfuNU9oNnPLEqi01HSdIivl/BV8gbKyJaYF
	eOLntOIVJ5d/q8HkLLH5yv9dilvYQRWnJwnavInpTzJo1/Cgz1oP7/4guc2WtEK7rTIj9EjBS1G
	xxifFfDpUdGqniNhSkYjvmKDhT9T+QtiOJCVvLEp9raZXY2mIWmZIYTATLQqU6clsdII0CbqYVU
	4pVkdhrgqP87FsGN/dTczf8fyUFXzpqDw15EJLlnup9bFGl+rG5h6AgmMyMixW/8yorVJTNI56R
	Q6YJWO15Alj0hAryvtJDzHSmoZN+frexKbl4RsOBpmnMsa3emm2V9dobjmJDLwB2LA/22cBSOYj
	ZHa7uz7KA7O9KPr+2njW
X-Received: by 2002:a17:907:9688:b0:c25:b620:d676 with SMTP id a640c23a62f3a-c2e23ca521emr232682966b.15.1790803428047;
        Wed, 30 Sep 2026 14:23:48 -0700 (PDT)
Received: from localhost.localdomain (83-233-221-82.cust.bredband2.com. [83.233.221.82])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2e31e053e0sm59849566b.74.2026.09.30.14.23.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 14:23:47 -0700 (PDT)
From: Yongzhao Chen <yongzhao.derek@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	netdev@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	George Moussalem <george.moussalem@outlook.com>,
	Ziyang Huang <hzyitc@outlook.com>,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2 2/2] net: phy: qcom: at803x: Apply IPQ5018 analog settings at probe
Date: Wed, 30 Sep 2026 23:23:35 +0200
Message-ID: <20260930212335.1565-1-yongzhao.derek@gmail.com>
X-Mailer: git-send-email 2.45.2.windows.1
In-Reply-To: <f8e1f642-8250-4c1f-be1c-713a0026282e@lunn.ch>
References: <20260928220717.939-1-yongzhao.derek@gmail.com> <20260928220717.939-3-yongzhao.derek@gmail.com> <f8e1f642-8250-4c1f-be1c-713a0026282e@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,=0D
=0D
> Patch 0/X should contain the big picture, and there is no need to=0D
> repeat it in the individual patches.=0D
=0D
Agreed. In the next revision, the commit messages only describe the=0D
problem and the change; the investigation and shared test results are=0D
in the cover letter. The code is unchanged from v2.=0D
=0D
Thanks,=0D
Yongzhao Chen=0D
