Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793649310;
	b=bp878EOfpAc8DBCMdnLxBr3idG0GEHgINE1Stin00pUP2eEu5IDeL6uUX06nhRI4jIiP
	 wHhH1pyNfLoSi+KPjuxWTRMOV9XiOtiYmzhv9/5pY3gQNxlxSf9HvaogYDtgFvgoqasGP
	 /pVQyulCaV1CF/ll01LhuA7hDViR3rvNMdH2qVciEnJiCqPi7FEhOGGdrW3VzPeORQTzt
	 +NZocpoKkhHrS0ROR9rjACNT6YVVzKBVJpVGCNOFD/KQNKFXq74B2waK5kfu/WKOnRtnB
	 tlnCu38Vv3O3M9vuhsEBdfMsRJ1FYYVCFs4sz4NlGOY05vUhv7aQDKtP6Pg4V8smvgA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793649310;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=G5PSHQPrweWrKkT8WtoNPp683en20LCojCs/UbDedaQ=;
	b=vmhNfxvQayY8jCxfphUMr4/3l+avfajA465P8VJb+9hPyHyoTxwBOdQsH1zwfAh8m0SY
	 4SbBCmRBluwSgaGkr1iPZQQMXSHrX+/oetiW9VYzYYUvTH3QPOJHzJEIMFsu7NmhDvNby
	 pAx3eq+sxBWSNOvoo7ye9ffTLHPRcT1vmjJwXdiH1srPm/pp0ihU+49eoQHZYoYnfZYLD
	 DwlKrUBtWPEn1tRYCYLyrI7uyG0on5FxLzxsjRlmK/eqitw/0LcglY8mA14/wt2JkFTXj
	 Q0L2SFFyopbzqDeOUGgP656QBy8id+d3gS8eRhAhGqY8s/3N/zh4bYmXoompO9APhDg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ie3O2A1E;
	arc=none smtp.remote-ip=209.85.221.52
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5392E606D828
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 19:55:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5392E606D828
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ie3O2A1E
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-48bbb06f29bso502635f8f.3
        for <netdev@vger.kernel.org>; Mon, 02 Nov 2026 11:55:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793649309; x=1794254109; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=G5PSHQPrweWrKkT8WtoNPp683en20LCojCs/UbDedaQ=;
        b=Ie3O2A1EqMo7JojmXQ+y8HJAfRtbz+7Cuufr0aP5LL19H3OHCdiUjK2XYs/lS+uNxg
         PpwXtSHms8m2fF7EnSwtAc97pP4+RtnGoDcaUe7Z6FTXkcbIetvqjyNo+4qPEDjryW+2
         fSItTjHCEzj6aaVMvarDXPCAtnnFGRLC7UT78OIVp2oKVDKj1Bh5FnQ0wmBOaeVWrRz7
         dbmj7Zz9TG0geaHKZcz6fc6DlKqEXRrVHUKqV4msfXymy1vb6ziDs0/l7fzj4bYfGWHg
         xqIf0RvfRrw9K+UXDOjn7KW+Y7PfZH4Ic+UfaH5qRf/7zCPLDvLVgRLtmQVCWdzggPI+
         bOqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793649309; x=1794254109;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=G5PSHQPrweWrKkT8WtoNPp683en20LCojCs/UbDedaQ=;
        b=xKrNFvllfYbWNpHUycA2SmLCM/Osb+TfmtTcb6OqKLtAzo/lJor9Ed6RbH1y1Zd2Xk
         nJ2EQXH38W7e6HZ/YhvbsSPhDv4hi+tfV39sMGrEIpI0eBMcv9NZdpKHG5Pa1zF9dgjP
         Xn7L1CvB/OdaUixKCwiJRU3xeeVTL/yWZSK38frEXo/w7f/+THs76eeY1hpNjrE5sX2m
         6gxn4/hxWTKELP/6hq1mX84TCdIzPQ9KLsb/Xdg2e8nnk68WmoCnV8XP8VFOoCkmAQ2r
         XN2FOCzbBP9aqUPSDBo3OsDpPve9TlMVyFcqTx0P3LibntF7bF+0oe+DTi5A1sPgSfd7
         DOVw==
X-Forwarded-Encrypted: i=1; AKwUvBwPTTfvP9Oo0TbtdtopO6WDYijlz2DQ40aOU2tGBFc10qnpiVd5T0v+zHBV+7GUjpWsPEUQouU=@vger.kernel.org
X-Gm-Message-State: APuU4Z8iqckoy2qS1zLyCxiYar+whPWHlLfyo4Fg3Ke4T62A9/ZYh1FP
	8MVvkxOPvFnUktOEW2PKI4anB3OnN1FZCrH8q+9m+JCtWOkcciloPpRi
X-Gm-Gg: AYBFou2t5H/lYzRUEAQpNiKFml1Tk8HjyjNzXU4UglYvrI8ydPeU8xvVLg4NuSCBXZ7
	6YWfGd6lmrhMj+O3xpjPixC4PKNmUfijdPiDdw0/pC73GJKh9OUhGuCmOHh0ATdwpe6r1kJFZxR
	Asd8BdWqYjKOQqcjtPkQWlJ3pZWdbGyVaSZui0ofsXI0nT/of9gEJUHaSqS1tenqU/XarVdHXTf
	sVskXAyw+XPmyL22Jc6RekR+0lTqoXg8n7x2siOzk3E3cbtW5aMt3g9O3GaGze+96aEi8vpMpCA
	WdfKv+3A0lFRuAr4FTjYUIFT37eFLqxIaBLQw2LRl/bG1Hk9CdwUyiVfRYB0QjgOay+5lot/mvf
	Krwx5y2kDS7BmHha+dUhJs3gBlRqQIta45vQl+qByONRuWAogv49fXIcWj4AU0GNN1zXO5EZom8
	4T07X/oewk3FANyHcjz0dUoUT/IWyE5ioutsNFQN0w7YTIdJh1ojp7YMlLyTuazS1z5je/iY80C
	QgqDWyGWXk/WdTMfjQF0IzvQfHtE4Kp8dnhTwkcX3ZY6pTOihIsG4FxkUINC6srTXAJUUCEK5BT
	AzCAXWweMLpM
X-Received: by 2002:adf:ee48:0:b0:48e:ac:a9ef with SMTP id ffacd0b85a97d-48e6e304064mr19849758f8f.5.1793649308417;
        Mon, 02 Nov 2026 11:55:08 -0800 (PST)
Received: from localhost ([2620:10d:c092:500::7:f93e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71b8bd8esm21670915f8f.42.2026.11.02.11.55.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 11:55:07 -0800 (PST)
From: Gustavo Luiz Duarte <gustavold@gmail.com>
Date: Mon, 02 Nov 2026 19:54:51 +0000
Subject: [PATCH net v5 3/4] netconsole: recheck device registration after
 waiting for carrier
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261102-netcons-fixes-v5-3-bdada2f03563@gmail.com>
References: <20261102-netcons-fixes-v5-0-bdada2f03563@gmail.com>
In-Reply-To: <20261102-netcons-fixes-v5-0-bdada2f03563@gmail.com>
To: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Stephen Hemminger <stephen@networkplumber.org>
Cc: Gustavo Luiz Duarte <gustavold@gmail.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.2

netcons_netpoll_setup() drops RTNL while it waits for carrier when the
device is not yet up. If the device is unregistered in that window, the
NETDEV_UNREGISTER notifier runs before np->dev is set and has nothing
to match.

We might then end up setting up netpoll on a device that is being
unregistered while holding a reference to it, stalling
unregister_netdevice() in netdev_wait_allrefs_any().

Add a check to confirm the device is still registered once we retake
RTNL. Release the device reference and return -ENODEV otherwise.

Closes: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261012-netcons-fixes-v3-1-1aac85ed7665@gmail.com
Signed-off-by: Gustavo Luiz Duarte <gustavold@gmail.com>
---
 drivers/net/netconsole.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 1680581c595e..238acf300d23 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -537,6 +537,16 @@ static int netcons_netpoll_setup(struct netconsole_target *nt)
 		rtnl_unlock();
 		netcons_wait_carrier(np, ndev);
 		rtnl_lock();
+
+		/* Check that ndev hasn't been unregistered when we released
+		 * the RTNL above.
+		 */
+		if (ndev->reg_state != NETREG_REGISTERED) {
+			np_err(np, "%s was unregistered while waiting for carrier, aborting\n",
+			       netcons_egress_dev(np, buf, sizeof(buf)));
+			err = -ENODEV;
+			goto put;
+		}
 	}
 
 	if (nt->local_ip.family == AF_UNSPEC) {

-- 
2.56.0

