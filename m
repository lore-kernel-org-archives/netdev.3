Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE1A733936A
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 13:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789564955; cv=none; b=QGXYD7gt9KMMOYEr7vhCF6fsEHbdZZzJ58hSrPL9B42HeC/cW8YsA8k4V+9p6sPsM8CEA6lviROEDTnH7vL2PIUzMyoKN55Irqa1n+4h2bFR5Bh1a6Js9TyPlxXs/OhMtF/BQG1BK5Lowgx+kO1s9GCyrUtpMd4fCowESz4etfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789564955; c=relaxed/simple;
	bh=73sb+U2UVlxIWkLhHN62z+gcjSVj+77RWY7foeTt6XU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=mFRcne3h7VWggRaTzVWa0tLEn/F/Cw4yYRsDg3scWtRlXiEW1y6fF6CNiwGT+eiQ1pa5vzxAWOT/nzpPe8s5pasTfS3x43Jba15NG2c+bzFn4Vlc9PsBBI7vae9qyhkpUeArAeLunVd5vo85R69ZxXyCQ+uKF/wp/eAQZ6lOW20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Y1903ZJQ; arc=none smtp.client-ip=209.85.160.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Y1903ZJQ"
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-5304f2b5946so115311921cf.3
        for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 06:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789564952; x=1790169752; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Fo6bWdsgvTN7PE4IBdVENZZa5bJ9HeNgEi863W/CASc=;
        b=Y1903ZJQn+6/0/BDpMFd7HWsak/l3d5M0v7flK3z5vCFJ2RP9T6saw1KZ2KkkM2aRb
         ZVfVUllXVErMykOSxnEIG76tHToaYDs8iF/qNs4lFEdVuNj9xb+kuDBDHmIZdCQ3BXlj
         0os3lTIE7XGUEBBnnIsap9/lU5ZcrOVJg/FzbDk74Bz8IFb0CwDXCXwm7HV5/IOvNYXS
         nfCNHABB6qxyq8xC4hsfanOwSPL4ywnQVV2/rmiI520FT9tN6lkzTKN1TMq4OIuUwOK6
         AcGvCKIe3mljF8QCP1DowZlHHj+g3j9Dr8lTY6yefk4h0lYSX9mpLplbPkC0Mc1Xmv1n
         yy8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789564952; x=1790169752;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Fo6bWdsgvTN7PE4IBdVENZZa5bJ9HeNgEi863W/CASc=;
        b=aWf6BDUsY9jYUZOEoLEsbN+tbQrm4XqlXC/GEh5oy4FvuoqNMkaqvt2lrg2ooWTdQj
         nVOY9CcmayBTaT85KvUUe3+h4zYSRwKXnUNP4tpSdjK7HQjglUAVhryMHg19hpEUfQGl
         JjMKEZDbxlzwk5oAv7z5BS4zbSN/vyXK2BFcLmNS6xlraFmnj9XcFH6xdaiVCVw6aOIm
         gC/1pWfnRJgZUgZjaZwMNsnDFEVDyzyERDcoMk1wRuim8JsTqiaN+qHqo84KRkeed8p/
         yAwd8zyu3MYdNCVhM2JVG4/YmA0L7tgI2BKQg5jaaO54+dPZuPPcdhJqKtFjG/c25132
         /1UQ==
X-Forwarded-Encrypted: i=1; AKwUvBx+ln041dcy4h6ZfF4L9YEqzI9tqJp/q3gpIhjjB74XjDg0Wfnr8on5l3AIEZCCR//gd6w3nfk=@vger.kernel.org
X-Gm-Message-State: AFuF++kL7By+h9sgg3Eam3iwxlKv79piqLETsyPC0WlTUxtyNm3kgVNn
	yDjcY3yO+obXp73rfzEAQZw6ao2RSlCQcsJnPNQKB9T/guqKQHSuJ3rHBNS8ltMZRqavo7IlbCv
	EbwOEBkV3VN52Mg==
X-Received: from qtbp15-n2.prod.google.com ([2002:a05:622b:cf:20b0:531:f98:8fc7])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:17cc:b0:530:b2e2:2f9 with SMTP id d75a77b69052e-5327f1d75e0mr44932401cf.59.1789564952237;
 Wed, 16 Sep 2026 06:22:32 -0700 (PDT)
Date: Wed, 16 Sep 2026 13:22:28 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.1032.g73a4cd73de-goog
Message-ID: <20260916132231.1780091-1-edumazet@google.com>
Subject: [PATCH net-next 0/3] net: rmnet: lockless rmnet_fill_info()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, 
	Subash Abhinov Kasiviswanathan <subash.a.kasiviswanathan@oss.qualcomm.com>, 
	Sean Tranchetti <sean.tranchetti@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"

rmnet_fill_info() currently relies on RTNL being held, because it
uses rmnet_get_port_rtnl() to reach the rmnet_port attached to the
underlying real device.

While auditing the fields exposed there, it appears that both
priv->mux_id and port->data_format are written under RTNL but read
from the data path without any lock. Note that rmnet_newlink() can
update port->data_format of an already active port, and that
rmnet_changelink() can change both fields while traffic is flowing.

- Patch 1 annotates the data-races around port->data_format. It also
  samples the field only once per packet and passes the value down,
  so that both ends of a packet transformation agree on the format
  (TX used to size the MAP headroom and set MAP_NEXT_HEADER_FLAG
  from two separate reads), and prevents rmnet_changelink() from
  publishing an intermediate value to the data path.

- Patch 2 annotates the data-races around priv->mux_id and
  ep->mux_id. It also publishes ep->mux_id before the endpoint is
  inserted into its new bucket, so that a concurrent lookup walking
  that bucket can no longer miss it and drop the packet.

- Patch 3 converts rmnet_fill_info() to RCU. rmnet_get_port_rcu()
  was only called from the data path and thus used
  rcu_dereference_bh(); its lockdep condition is relaxed so that it
  can also be called from process context.

The lockless lookup is safe because rmnet_get_port_rcu() checks
real_dev->rx_handler before returning rx_handler_data, while
rmnet_unregister_real_device() clears rx_handler and waits for a
grace period (in netdev_rx_handler_unregister()) before freeing the
port.

This is part of a larger effort to remove the RTNL dependency from
rtnl_link_ops->fill_info().

Assisted-by: LLM
Cc: Subash Abhinov Kasiviswanathan <subash.a.kasiviswanathan@oss.qualcomm.com>
Cc: Sean Tranchetti <sean.tranchetti@oss.qualcomm.com>

Eric Dumazet (3):
  net: rmnet: annotate data-races around port->data_format
  net: rmnet: annotate data-races around mux_id
  net: rmnet: no longer rely on RTNL in rmnet_fill_info()

 .../ethernet/qualcomm/rmnet/rmnet_config.c    | 54 +++++++++----------
 .../ethernet/qualcomm/rmnet/rmnet_config.h    |  2 +-
 .../ethernet/qualcomm/rmnet/rmnet_handlers.c  | 34 +++++++-----
 .../net/ethernet/qualcomm/rmnet/rmnet_map.h   |  9 ++--
 .../qualcomm/rmnet/rmnet_map_command.c        |  9 ++--
 .../ethernet/qualcomm/rmnet/rmnet_map_data.c  | 14 ++---
 .../net/ethernet/qualcomm/rmnet/rmnet_vnd.c   |  2 +-
 7 files changed, 65 insertions(+), 59 deletions(-)

-- 
2.55.0.1032.g73a4cd73de-goog

