Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D5F3290DB
	for <netdev@vger.kernel.org>; Mon,  5 Oct 2026 06:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791180894; cv=none; b=f+E209Ofe+r9r7pljaIEGDRqy4Cceya+7xaJiMMKEr3erHZVj/jBV3mY+cMR/zAGvs+uYueaRNgecIt/YYpSl+iNSxxARbW7jmbQsapMNZsemwRvXWNW0Y2wla5awZEt77Yeg72aIkhL09xUKfBuL7JstxLVj8KjT8EYAXhgWa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791180894; c=relaxed/simple;
	bh=uD/nb4O7ZbLjFJE9S7MPQ2OU8Ry8eaH9EFc8B05jpd0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qZXOGsw1nfNONI9XA8z9pyTa1aTOC9sbRF8Pq+kPtgqobchXsC/fCvNXP0DxFvjFHjBrnMgwTEHGBLmJSyJplTP970155Zu0V0sKPcdnxwhhkgmcxoEGBLOoPd/MBfNQUN9nZ+GOEItcR8JTNa8ePxv5LpTYY8fL2AMRmGcKuEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GF99Z/lP; arc=none smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GF99Z/lP"
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-351348eb579so142630eec.0
        for <netdev@vger.kernel.org>; Sun, 04 Oct 2026 23:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791180892; x=1791785692; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uD/nb4O7ZbLjFJE9S7MPQ2OU8Ry8eaH9EFc8B05jpd0=;
        b=GF99Z/lP7aN31CIMG+/6AiTfigp8XQwqLqrenTmEBdd19myWxwGgLcEkVzYqwTn8LL
         o32guqGacQS8qK0QLf6osz+0wPfIxfhj2d8yaKdeLGe4MohIsKVKbqzyR0vottYVXucm
         zfK6F7uGwKIg4wxZjRhXXrXHvyXOW7JFtp9ZaQ6RiAwI+pkaEoBv6SJpBG6q9TWXevET
         M1r2rlDCyALuT/qF7CV6rJPqmcaDZ2t9AEGwNm079QRwCsjRrXm85lDk8xhnc5kS8xjJ
         vebZslVaJZps9VtYmSUYfaj3BXGygVxA+jvOOyULYiuBjnpW2ZsNzDpnbapxYiEtA7vI
         58Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791180892; x=1791785692;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=uD/nb4O7ZbLjFJE9S7MPQ2OU8Ry8eaH9EFc8B05jpd0=;
        b=on794uUl1oncuZ4T5jsmjgoWO4HwnFyFT1DQ+hXxH8dhmhz9VIrlAcyurMM0s2iPxw
         Ym1I/vU1PTNj/nyAZ0cpWq5Bmc5J3tw2kuMdvZjP700q0vk8V+yClOLZRI6/1IKeePZD
         htjy9+zCvk883hBg2xkV+hyKrb9mdCO1EyZTlE0hYwqHO+VyN4frzyoKAXks9XgsOsX+
         H23dN+XG/rrNNSu+sTTeF8GWBC84xK3pIYDWBEJvrHvXSNPhMNwBj31UP7xNNgeBdrFc
         s+hUmv/5KTHhW4ZuanZ+woQv5RqEHQjwWWOuB22yRiIpMAqvE6tWaJPrH85nhCAskqnP
         2GIA==
X-Forwarded-Encrypted: i=1; AKwUvBwkWIQxiVCRwXSIqe1yr8U83ZBmld5LpR7mk7vm8Ib7DGS+Nw91bUjb+9DsaC/CbKpnK9zIrrw=@vger.kernel.org
X-Gm-Message-State: AFuF++kaSggEWcn3ydcxS7If2magh6pBiz/s6Q2+TPZxXxt0WWxGH40/
	86caNAeGj4CnT4dJZVrWjB5LiY9HuetKQ2b2W51KtsRbt/yG6WhZIOQL
X-Gm-Gg: AYBFou1ry7m6XDQDkMbcnVG2x3ovl5f8zyn8agH35Bn1siwlgQh7pvIlJU7FTr1ZxGC
	cs20Rd6rh6JUJZEesdjszykqpL7rNJhGGNyENV6yiHQTeha7ghki+zIz7nGFNevVI8c9lZ3WUyJ
	LpluNPjftgRuWbSD3sg02qZok5FsI/Cojl/o2d/QucfzMvamYrBBpvfk8OXeA5rQBNrCt2tgyNa
	c4RNxpOqkhaTe0Hu5hGvDlMVhoKWvi5n4BDWlzOBxSGQgulLZheYbmeInkRwWx/qIozmON3ft9S
	P7tXrwT8u1x6IqSEYiLFyH8s3dM9NkGg3Mc+HDV4f1k9ATz6MIDjzLm2JUMXEFcmBXkmliUVlun
	PcobuHJtArVmG+ahoIYhJ2tUxJM2fqhTYhUci2uNcZlnYU/0qqQDZFH6iXW1j1xz7JGUXCMvmXv
	uJ1rn3zCWCj8EkdnlSPpH3Bjq/UZDCqKB5OYECOvd+10Q/o9zTZUMMUx5v0+yLdaRNJrCu4kW2N
	E+5IAPwlwtgM1cr+4KuXA==
X-Received: by 2002:a05:7301:1a8c:b0:33e:6877:ca6a with SMTP id 5a478bee46e88-34db77d1fd5mr14503161eec.26.1791180892305;
        Sun, 04 Oct 2026 23:14:52 -0700 (PDT)
Received: from umang-Inspiron-3501 ([2401:4900:1f3b:8187:3c00:622a:7472:e26b])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3512718d9edsm10968288eec.19.2026.10.04.23.14.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2026 23:14:51 -0700 (PDT)
From: Umang Pokhriyal <umangpokhriyall@gmail.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Jason Wang <jasowangio@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2] tap: report IFF_DETACH_QUEUE in TUNGETIFF
Date: Mon,  5 Oct 2026 11:42:35 +0530
Message-ID: <20261005061236.22907-1-umangpokhriyall@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <willemdebruijn.kernel.3720fccc8b4e4@gmail.com>
References: <willemdebruijn.kernel.3720fccc8b4e4@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Willem de Bruijn wrote:
> I suppose we want tap to expose this state through TUNGETIFF, like tun,
> because applications already use that?

Yes. CRIU reads IFF_DETACH_QUEUE from TUNGETIFF when it dumps a tun
file, and Cloud Hypervisor did the same until it found that macvtap
reports every queue as attached. Code written for tun's queue API gets
the wrong answer on macvtap, even though macvtap accepts the same
TUNSETQUEUE.

> Else cleaner than working around bits would be a whole new TUNGETQUEUE
> call to match TUNSETQUEUE. Rather than to squish this into TUNGETIFF,
> while that has no equivalent in TUNSETIFF.
>
> But, that approach does not help existing applications.

Right, those applications would have to be changed to use a new
TUNGETQUEUE.

Thanks for taking another look.
