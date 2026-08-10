Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2084F42BEBB
	for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 16:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786380473; cv=none; b=nb28JK0ofJtAXe2R0S7wRIIiAiHtPN0RrAF0tPQVEPhfMRsI4OyXZMScttBCOCuBsczGC2MckMTcR7t2oQt7HD8r2Xm/bqM7e44PzaySJehQyu0dhPbiICnRR9slQqJYjIDP0jL9XWX28xOOE3vmPAvqDcx9Me2KncfnS/VFCDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786380473; c=relaxed/simple;
	bh=XcdFhWSjpZ8I1EIIuQNMMN7Zy0MPKSEdmoyU+VFfNMg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hcJCpOeDEgQQMhp39Ekka3Wmxai8gqWJ3nkUDSdhLM7sY4T2Gjz/Lv0aO2YWhC9qtd7AO9q+NZpuhlEpdiNCV+wfjAM6DtV+6W46giuvCyOXIFfL56cExwFlG7FpCQGbv9dlB3jEzojU8Ef7WIxTspDZ+vtH1SRFpAL+ADvgXWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WW3zCKck; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WW3zCKck"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-47c2ae992beso165940f8f.2
        for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 09:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786380470; x=1786985270; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Lb5+5JTC9yhaPKpWNbGAJrFXvPh/cPi2R9FXngaeHD4=;
        b=WW3zCKcke63q0GO2C+CsKnxGf2PCGjErAAl4/ODYxJibWkar0Usmzxh4T1n6US0Y9A
         UBlSJmUfzH80U4i1yg792j2MYUB7F57FZwOJBuRbhauDReKpl2G0ufoDF8xcT8OdK6Qv
         xBmM2lrGSy8bejbW0Gmq+leIoVSyGLviVYL1hUmtwbmpqBl88vcZZDhSCjHv4Ptt38Yk
         GIxqjcYivjVymbIIL5Soc/kh4mlFQHX5AqeGnmPoBi7p/7KGcHfA3OJ6EJmPtU0Zwz4Y
         XG8O25oBx3NOD1f2qkXpdXTsJbWMIaK8lY51vd7btnR8iM9LK7eqmGioPUaWbMOcGtdc
         AA9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786380470; x=1786985270;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Lb5+5JTC9yhaPKpWNbGAJrFXvPh/cPi2R9FXngaeHD4=;
        b=I258lBTTJgGCc/cqf9CNpwojwqDU21DRei+OCCRRPLQC7xWub1WR/j21KCd2eUHN/y
         nnipL/TTsCk9PCrQtw+pqYPyCuGEPDSVERCLMYO38GWM7sNar8Lze0d+6sQHDXJHdpYp
         wYXK1iBIQ88BSRkgK4V/TCMgKmY7e+Z/aE/U4/qdvbjUyBcVsw5BCtJTMQdp58zLqh5G
         0mu+dCvBxhsP3XbOxC4MevLc9t6Cz6+MwNcVe+qwFMRekzOhiolslLgI60pk3qdD8r9G
         2K9L+6+JUZb8a7fEdbzHAkjyPOgaHMHjK/i9vED7jWCW9vBXoRbSeCUvbvSLjqJo7dut
         1R6Q==
X-Gm-Message-State: AOJu0YzYRdbj400dOz5RJ+ufhPAH3PoKJbJR50dpjCiB6XF7WcHufKII
	Q8j+dsGb2ROnfVyY7R98aJP7+whnFSQi4lF0Ec+yJW3biEXTEDN7O+bI
X-Gm-Gg: AR+sD11sSKe5zow5b76DdnQ709qA518RIUzz172t+/QU4IIKppBa5UfKZVNLU9p+RQr
	Heoir98CDFW+CQ0tymcDeaI5VVLydMdr01gWZiF0m76e7OQ/2a5DUI/ClqF0ru3ZZcU+Zu8HU1A
	15mKfhI/hizirOa6p7VmxT32VT7SyLHwIoZ2Uwx4RjE7O8q7GeA2jbeVBz4AyHP0U5j3W7s4XWS
	iDr5KzacVuTNdK6bsTFdB49rhzGSYrIjbpudCaaN1oC1U2kbQH22lfXgBETwyqsyyAkZP3wXtG1
	soCBfbBjTEPX/N4kZVny/BPx3SgVxs1T1ycPOmqV8hd7GbKtFGjtlz9i0DAOovieUwzP1i3sGzI
	SqIweM8JUSbnk5HjWN2PIfMPvrY3TpbhwahbWFIWsFFNKM/HD5UJiVbHX3krL8m9mUZ1rTi9SeX
	DgfO1TJHGlRkulSkCyQ+QDDbfmyFaR5qZmPR9zPpQoGFz5l54oSOjllg==
X-Received: by 2002:a05:6000:290a:b0:47f:7526:5a0 with SMTP id ffacd0b85a97d-47fec47628bmr32828119f8f.0.1786380470283;
        Mon, 10 Aug 2026 09:47:50 -0700 (PDT)
Received: from localhost ([2620:10d:c092:500::7:692b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-480021f9182sm37080011f8f.28.2026.08.10.09.47.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 09:47:49 -0700 (PDT)
From: Gustavo Luiz Duarte <gustavold@gmail.com>
Date: Mon, 10 Aug 2026 17:47:28 +0100
Subject: [PATCH net-next v2 4/6] netconsole: reject a target mixing IPv4
 and IPv6 addresses
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260810-netcons_ipv6-v2-4-3d4fc987a90f@gmail.com>
References: <20260810-netcons_ipv6-v2-0-3d4fc987a90f@gmail.com>
In-Reply-To: <20260810-netcons_ipv6-v2-0-3d4fc987a90f@gmail.com>
To: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Gustavo Luiz Duarte <gustavold@gmail.com>
X-Mailer: b4 0.15.2

The local_ip and remote_ip configfs attributes are written independently
and nothing stops a user from mixing ipv4 and ipv6. This leads to an
ipv4 address being zero-extended into an ipv6 header or an ipv6 address
being truncated to its first 4 bytes for an ipv4 header.

The command-line parser already refuses such a mismatch. This adds a
similar check when a dynamic target is being enabled.

Signed-off-by: Gustavo Luiz Duarte <gustavold@gmail.com>
---
 drivers/net/netconsole.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 7fcdff53b3a4..054c39066043 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -475,6 +475,12 @@ static int netcons_netpoll_setup(struct netconsole_target *nt)
 		return -EDESTADDRREQ;
 	}
 
+	if (nt->local_ip.family != AF_UNSPEC &&
+	    nt->local_ip.family != nt->remote_ip.family) {
+		np_err(np, "local and remote IP address families differ, aborting\n");
+		return -EINVAL;
+	}
+
 	rtnl_lock();
 	if (np->dev_name[0])
 		ndev = __dev_get_by_name(net, np->dev_name);

-- 
2.55.0

