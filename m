Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D1F32FD1AA
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 18:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790618471; cv=none; b=Rt2XNQlEWueyJoucKDbvS9XV2CGHCetlyKR5Fnyh2jxr5dr2WWwlkFi7KABr+ILuEKAa2M1q+UPPD5vup20iHmRHf+89aqQA50satcpp5JoPj7WAEEU4srDHnXSYfQkBl87cIVR5hpgjzPtfYk5BJcTbqUCDpZLFTU+Wo2Kk1nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790618471; c=relaxed/simple;
	bh=hCjncUcjccL8dLLQkdqgionB2mq4SnnDe6up7exhToM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=STanmvbgFExoqmbSdmcr0d6CFl4m3Hg5N8VaXsICZEcIj0gy7CNp3p8FxwSE6xmKYrgcwULHeQ9ZUjDCOv7ufZ0yv7caoivLbO+cioxP3/U1tgchxEDVYB/yF3D9+W/KFVZaGtITV7LZCTedFz7PlywOrUR45d0TRx+Av7H2H/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JfwFC3/A; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JfwFC3/A"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-484399babcaso369653f8f.0
        for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 11:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790618468; x=1791223268; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Kfh49rBnp+fv8rYbtPwFIFAZ780+WTkGnS4eo4NPc78=;
        b=JfwFC3/A+g+/pwKCMx0IVPg8SXQ0H9Jbn0XLGlIFKutinPeBMPWwYQkZLBATaZ+F5S
         S/buuuH51QMU2IA65IqnUTRZQ+vXg3Azxs4oSNgK1x6H5VOyXfDDdP6OsNMu6l+j47+h
         Mf6oE7lVzDG5GarVZOS0oXzasa5plOdcyMu5lCmoiRN/AR4T5DgxflcN6HzrIrKjmn9e
         61rjp+kn2+o6SlRyKOfbRadUNmFVbMkDBHOOyhWwADncdR7Vg098fJaQqaxf+zsdm9yu
         zY8ztioiaCnfu08KZvq2vOUzJ2qie5lvhMJ0FOpIUhkkE3fTHj9Kp93Vo7n3VAwiUc8d
         ogdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790618468; x=1791223268;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Kfh49rBnp+fv8rYbtPwFIFAZ780+WTkGnS4eo4NPc78=;
        b=vSvjSEWBtpdSn9K7zU62lEwlszNZbPYfEBYr4er/+NHUqt6KBvES1aY3FiUfxzgTtH
         0VvzovhPNxIYah9ogimjXJdYtAq5XoyyvORizSwkTAgWj72EjwBt9I00FU0poOvylVzo
         K50q48yZqFZOHMcdPf/Ev9fzgje+QU8BnhvkpH3a4OUpLu+eULfQpJ+YkkTMusyPNyWD
         V3yhcTgU5dxQ5LSPFNE4Erswe6iXavSTEmII4Zcethu5AZQaLaOYANB2xxwYXkE54k+U
         hK2ayBGtI+b9kgkfGsZ1x8Ec+NijvKgcehcXzMsRILYH2wfhtS/9BdXBBqZdPe/ZfU22
         knjg==
X-Gm-Message-State: AFuF++mk7K/b+BRtHW6jIiAgqKMGFBQ0Q0ixw8JbBvAkcsEJbsTdDw5F
	7XFsj0v49I0XnGkS05ohvrlIKImuUBvegQ5Ei7Vx3OaAiEmim+IX6uAU
X-Gm-Gg: AYBFou3ZMuAGGSIRg8QJ0rlw3XFzJ1NZhChiXr3wQRMV2TWqAUUsBiya1NoT6yS9LOP
	ydSI/hFNl+nZWUvibrVF+O8ybYUgWRYwfjbA5bnqMYFfNEUFUvbjVpunXJ4+UVccuKLNyRmCs4d
	g1k7taB6y7u0Uj2De/WnGcHeHxUP/eawoC0ZqTSsoxdvGfDGEbo/DoLH6VClgUjKp7kaeUsX+tq
	W29A6infCuwTWH+q21i4xR4+jRugObglLNZxvpLt2v1vRZisSnmmQnPNHgcFWeCFgpmE3Yt3eRP
	LcmohB0sUE5A911Vmfm0PIw1yDRaAdj676hHG5dB0xD4VoMyKivuDE4fmDXHCjKgsy/6CD97/us
	o4cVSI4dfcl7UpnilUvTa4CHhsB1cCIltcRUlEvBCVIxAfgeanl7jzc5tM3ysloKCBaDXV1fW1k
	s6UBul1eqneJpBs5AulUQkykb8o7tpMKqLRwINTm4O/muvRvuOqkvY
X-Received: by 2002:a05:600c:c48e:b0:49e:6683:d227 with SMTP id 5b1f17b1804b1-49fedd2c6dfmr164489635e9.0.1790618468247;
        Mon, 28 Sep 2026 11:01:08 -0700 (PDT)
Received: from localhost ([2620:10d:c092:500::5:c231])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a00cf4598esm10991745e9.0.2026.09.28.11.01.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 11:01:07 -0700 (PDT)
From: Gustavo Luiz Duarte <gustavold@gmail.com>
Subject: [PATCH net-next 0/4] netconsole: fix target enable race and
 configfs read locking
Date: Mon, 28 Sep 2026 19:00:02 +0100
Message-Id: <20260928-netcons-fixes-v1-0-bb5ffe5e698a@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWMQQ6CMBREr0JmbRNogQSvYlxAHfW7KKa/GBLC3
 f3K8mXemw3KLFScqw2ZH1GZk0FzqhCfY3rQyc0YvvZ9PfjOJZY4J3V3WaluCGNg0wbfTx2seWf
 +B0suMNX0teB6LLpML8byu8O+fwFeDvocewAAAA==
X-Change-ID: 20260925-netcons-fixes-93a3e14326b5
To: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Matt Mackall <mpm@selenic.com>, 
 =?utf-8?q?Bruno_Pr=C3=A9mont?= <bonbons@linux-vserver.org>, 
 Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Gustavo Luiz Duarte <gustavold@gmail.com>, 
 Sashiko <netdev-bot+sashiko@kernel.org>
X-Mailer: b4 0.15.2

While looking into the sashiko report about local_ip_show() and
remote_ip_show() missing proper locking [1] (fixed in patch 3/4), I
noticed a couple other places that need locking: patch 1/4 fixes a
null-ptr-deref when enabling a target races against a NETDEV_UNREGISTER
event, and patch 2/4 fixes a use-after-free when the local_mac_show()
callback races against a NETDEV_UNREGISTER event. Patch 4/4 is mostly
cosmetic but worth fixing.

[1] https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260814-netcons_ipv6-v3-7-bc0915e8c75f@gmail.com

Signed-off-by: Gustavo Luiz Duarte <gustavold@gmail.com>
---
Gustavo Luiz Duarte (4):
      netconsole: finish enabling the target before releasing RTNL
      netconsole: read np.dev under the RTNL in local_mac_show()
      netconsole: avoid printing partially updated target attributes
      netconsole: remove unnecessary target refcounting from the netdev notifier

 drivers/net/netconsole.c | 110 ++++++++++++++++++++++++++---------------------
 1 file changed, 60 insertions(+), 50 deletions(-)
---
base-commit: 014d795c73837ea2339a4ea8e8f82c6e959b845d
change-id: 20260925-netcons-fixes-93a3e14326b5

Best regards,
--  
Gustavo Luiz Duarte <gustavold@gmail.com>

