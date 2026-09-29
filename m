Received: from mail-dy2-f43.google.com (mail-dy2-f43.google.com [74.125.229.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C41F350B43F
	for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 11:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790682644; cv=none; b=NjqhZ7OdvgnPpsbDO08u9pTP/sZQ1K2weSzS5ouINDcjW5Iy5KBHwBRghxtJroetT9meWyqwNUt6NMk2NcKGcFzOFXxoS9nPC+Jwef9w4hf6kUOAtzv7aHsOsupUaS4erNf0QIN/Ii/G094YumNINgcNxRUbLDMgGe5FNlEj/yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790682644; c=relaxed/simple;
	bh=s/0XDKChj3G/cqYADLMvz7qCruLjKQTe4fIV24BbGCE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t1inmYxtojMSC2SNYQkLIpXye8vcWFFHSpHQgfzXCP2OPI+T5HAoNLa0xGIXyEKxz2YR9e2dUcM8YyTkCqjSD0yt9SoBjg/4izAzfw7ixOTtzn0r75++UMCk9P8oFyxJP7o6skK6R3GQblpIgdPeti7GK0GWtrtiEz+Jti1VHMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=smartx.com; spf=none smtp.mailfrom=smartx.com; dkim=pass (2048-bit key) header.d=smartx-com.20251104.gappssmtp.com header.i=@smartx-com.20251104.gappssmtp.com header.b=PL+EveeZ; arc=none smtp.client-ip=74.125.229.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=smartx.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=smartx.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=smartx-com.20251104.gappssmtp.com header.i=@smartx-com.20251104.gappssmtp.com header.b="PL+EveeZ"
Received: by mail-dy2-f43.google.com with SMTP id 5a478bee46e88-34b223602d7so452679eec.2
        for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 04:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smartx-com.20251104.gappssmtp.com; s=20251104; t=1790682640; x=1791287440; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pxSUmylHrG/sfdm4UwKqO9ldN0EF/+2SLiwtNhPJqzs=;
        b=PL+EveeZlSMuEU4WbsHmXY9ZCJZwk0LcJUjsY/+b5OhbWyCiSIXV5t4zZ53J0yFPmo
         2feXv8QcLHgDVembGYqCi5ZMOiuKcT5d1qmuBDscKORZaCxZ/94V/Z/hcrpzoGx2drMK
         7Jb5QYgWbZCJpmv40ek7uklBs/wXfwm0f4Ezl9jLiJVrTxBUFoV/aWkp9OQPilcthydj
         BL9HuSQ1OJV36bmER4xG71RXLM6AzRvJs8mK8RX6C5ynP5iZkhYDHqmZJd4sKWb+tcPG
         +6eZpymI5pLFkgNYJBK3wmUFO+ZU0Hp+z75Kx2nGTJn67C10mitFFlWxCqTUM88K3Q03
         3iNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790682640; x=1791287440;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=pxSUmylHrG/sfdm4UwKqO9ldN0EF/+2SLiwtNhPJqzs=;
        b=klPkl4d8qhxdIuIS/aWpgNBShiFOJsr0wMPs1kCqPwp84gi7upUBIlVy6J6wvdLFDT
         WU7xoTFeqa93XO1ArLEOcdOnqgH4aoeSW8S6BenIAzopQjYqT65ySAWB5l0GnKByBNV4
         QkLJ+xAaXwoh69H94l5dSSTk88tY4/DVkwgcD1AK62aNBbd/SP060BXOqfJscXKMxvYU
         +vK3KG8MKvCaVpX/IrJ8QMShQwzm5MqHvfbo9J4DI9I6RxBtkV8+GQcOMXy8rSE2zc8H
         yqs1irOFQ40yPbKsXz29iMdbhLRKOvyg1O2srPe2+Wy6r9Biy+S4M2Yb1rr0sZ0OzOMU
         CciA==
X-Gm-Message-State: AFq9FYJoD57CBUSqquMUqwQOLC6N8BinW7p0Yp5YitSaYZjOovsz6L2z
	Pd02FnBgZTAyssGg5mEK2l4CVZTh0NAoCbC1FkRNJeNMskex3W7rdsQVVaB3N3z1wiQahILHvtI
	P3W0BsaGOvii3MMHaT9OHePHG5KmhW15kWOAhxLztLsm1I1vaVFT1BnfQMcy3RsE3QyP0VnxL
X-Gm-Gg: AYBFou1B/6IvWmlFA5+QUG2oDlVNh8iKbS7oiQIPndaydbnc3PK2d1prirxmgz8i1vK
	cm4ChB8LwE69JpwusSdRkY5LCvuegmZOds6rhO/jvF9NHZF2bMDnug9qS5QV7XHDsOrHEH/gqd1
	Lvt4qURLIF8OHRDE1eBvZUDL1gI23CIrHT0fTGf5+/DJWNlroNMi7CtEKM30mJA5mOzxr/+tc3U
	26rNXwsyqEqR56N42pppzRA/nvevjpw5pKl2Q/ybQ+8x55+I1AI5aY+3ceMHh+4FesbjovuJM8I
	AUC8qciMPZENu2F7U6p/dNO+QLJapaA817yLZcJoio/6NbpybOp7K1BSQx4gTwb46/Orl7fprC2
	29e9hpLYZMwmkmzhuZgiUXLTq5LdyUE95gU2jQC742Vd63TUMW6Ku2qgwzm26E/ETt6+RK90iMP
	D4uDfKEV5SrYne9z1MHr40ljmsKBjRCQwKd9jyAjwtu126DHH/hp1GXaBECJz0Wha9Gh8bfMQ1L
	LcOlBuhMkM=
X-Received: by 2002:a05:7301:428b:b0:34b:c18d:c294 with SMTP id 5a478bee46e88-34bc18dc772mr738249eec.24.1790682640193;
        Tue, 29 Sep 2026 04:50:40 -0700 (PDT)
Received: from localhost.localdomain ([23.148.204.240])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-343580930e2sm26228179eec.16.2026.09.29.04.50.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 04:50:39 -0700 (PDT)
From: Wang Zhan <wang.zhan@smartx.com>
To: netdev@vger.kernel.org,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	keyong.sun@smartx.com,
	Wang Zhan <wang.zhan@smartx.com>,
	Jason Wang <jasowangio@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Aaron Conole <aconole@redhat.com>,
	Eelco Chaudron <echaudro@redhat.com>,
	Ilya Maximets <i.maximets@ovn.org>,
	dev@openvswitch.org,
	Daniel Borkmann <daniel@iogearbox.net>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Alice Mikityanska <alice@isovalent.com>,
	David Laight <david.laight.linux@gmail.com>
Subject: Re: [PATCH net-next v3 0/5] net: resegment oversized TCP GSO skbs
Date: Tue, 29 Sep 2026 19:50:28 +0800
Message-ID: <20260929115028.2014285-1-wang.zhan@smartx.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <willemdebruijn.kernel.39a32e51cb66d@gmail.com>
References: <20260928044102.1004310-1-wang.zhan@smartx.com> <179057071651.31693.213200671694715782@kernel.org> <20260928054920.1434795-1-wang.zhan@smartx.com> <willemdebruijn.kernel.39a32e51cb66d@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 28 Sep 2026 19:34:21 -0400 Willem de Bruijn wrote:
> If 1/5 fixes a bug that is reachable today (does it?) then it needs to
> go to net on its own.

Before this series, it is reachable when the tag is already in the frame,
for example a stacked VLAN device or an OVS QinQ path.  I reproduced it
with the following script:

  ip netns add g1; ip netns add g2
  ip link add v0 type veth peer name v1
  ip link set v0 netns g1; ip link set v1 netns g2
  for n in g1 g2; do
      r=v0; [ $n = g2 ] && r=v1
      ip -n $n link add link $r name vlan200 type vlan id 200
      ip -n $n link add link vlan200 name vlan100 type vlan id 100
      for d in $r vlan200 vlan100; do
          ip -n $n link set $d gso_max_size 524280
      done
      ip -n $n link set $r up; ip -n $n link set vlan200 up
      ip -n $n link set vlan100 up
  done
  ip -n g1 addr add 2001:db8::1/64 dev vlan100
  ip -n g2 addr add 2001:db8::2/64 dev vlan100
  ip netns exec g2 iperf3 -s -D
  ip -n g1 link set v0 gso_ipv4_max_size 65536
  ip netns exec g1 iperf3 -c 2001:db8::2 -t 6
  ip -n g1 link set v0 gso_ipv4_max_size 524280
  ip netns exec g1 iperf3 -c 2001:db8::2 -t 6

With gso_ipv4_max_size = 65536, iperf3 reports 442 Mbps; with 524280, it
reports 39.4 Gbps.  So gso_ipv4_max_size clearly affects this IPv6 flow.

I will keep 1/5 in the series and drop the Fixes tag, as Paolo suggests.
