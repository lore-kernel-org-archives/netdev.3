Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794574854;
	b=yOmGfh2DjebG24MIrkPZTE5wMfuxlAQC/9eQQ1duuI6sqysAajw3O/YHVp77yoTIJt1d
	 Pc+H9BZu3J8tpKuX25RzxrOqnNwyWkHSRygUcy0ktj7qM5NdWfXOdxZTMVq09ADELITeR
	 4k4P0Wc8nPckoYfE3LSAvzFlYgQCxvGA49u5N9MYu9/8jBEua8+S1MiC5bg86VwR5IWkP
	 T/TkvT4x7/q4uyY1pXvjsHp+9S0SytGCP/M9bi+y+ti2C6+iYRTJpct8U3FZEXKSsaZ5a
	 2XbnIesjyqO+B5c5Z7uho7aZxgYcG0NNlFFg8tiGRJupNQoQLGd7tk5e4MXlgy1UvGw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794574854;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition;
	bh=ausK2Hqw6RicprXH57DI+3UxTh/DJKcG1J43hpFqK78=;
	b=Py2h3dDvEXRAzCyxsk08DPw5hOYWnLAkQJmP7BxbERhKt/gyGR1pMvxKH/mdJoyhast0
	 FaFBGlzqPX5ZnhVOQA4IjEWro8W0GMtqppSMDgdu186ovgyCtMufOJtJAqbx97BUkcXLQ
	 0ALfTK+DTRKA7fGb/DIiwQytI1N658CT8wvN35UAKrNO1BRU0ajK3kLdfaUGyPbB8JyjX
	 gJ1PIJiRW1fcZjy+UAxZeb56XnXar9l/9x8z76xnaZlKzw21sVzg+ZL4j4LOwkBpMopvG
	 i7tBOeui8Lq7AaENw4Z+JUuLyz3kZk0Rc3ZkdCHSLaERTPUac0jqbqKPBvMIIxS4ojA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ADlDpwbs;
	arc=none smtp.remote-ip=209.85.215.177
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90788606A323
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 13:00:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 90788606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ADlDpwbs
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-cdb2893531bso1025475a12.1
        for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 05:00:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794574854; x=1795179654; darn=vger.kernel.org;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ausK2Hqw6RicprXH57DI+3UxTh/DJKcG1J43hpFqK78=;
        b=ADlDpwbswhOacg7fyvk+in2bKZUyXAhNsf+Q0lS9SNNwsAdFxMwwLbYREWuOOse2lx
         K/zcDykKVYlQdFhx0FGhQa3h+A8cE3nz/ofBAp/JCl07i/RRfe/5p+3edT4gRvzORqQJ
         G+uEMQq3UuNaWIAAnf0kWBjZI5zi8eQ4wLn2KwIuueA3J9/xA2/u59k6tc5h2vihwARO
         WQAXTDLRMTiBTvxT/0kGLcyaCvy8zYS/VkLcsv7PdMgIgXD1pxsVcPF65mZ+U1Qy3iTR
         xVobLE2WyKvaOad0rhynnzoy4cEdo6D3ONhzA3syCQXcoE9mJAlLSG6gqJTbCHamcX02
         a7vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794574854; x=1795179654;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ausK2Hqw6RicprXH57DI+3UxTh/DJKcG1J43hpFqK78=;
        b=v3PSGGt/vXsVi9sfaX0DJgQpad88KQ1W6GGTU3qUWgoQIXfrHGeJHr5GftqC4okWST
         mxnq+NWzxhPqM2e6opacMZyM7mBBmYeiu7bFILo1aNYGcF3hvblRNi/yL5egWdsg+QyB
         K+zSBQFQOaKuE38ZMGZo9EIrKxf/zBNmcwcKuY0UWOn48iVHpvOj60UImRXOzhYyquBp
         QyLtVTZccpAeXcuwe8QL91z7WwK9G7rAXokubl+FDpW1pV6yjAnk/5rdkWTlHcOBY0h5
         FBf18LH4UwNBrkZWic4BP4B49uh58k4q+QDLGefLAEqKks3RjAbSzmMPVAPQl8vPWeU/
         6qFA==
X-Forwarded-Encrypted: i=1; AL+hErG4gtvZXEhoMAB7g76e7VyLRpOIZ07SEBGucafZRss8T2WTrRbd92eqCaxfzaDJmakEW+6agaE=@vger.kernel.org
X-Gm-Message-State: APuU4Z8K6oV9V17OanGZbe5kjhzvOEFB//mqDTgHfxdoRmO6C7mVoI1X
	dQCXHBvXl8bBXf+XS1updFWBoCUd5GPOgEnFLwKV4+GfuFp4kNn9bgot
X-Gm-Gg: AYBFou0AT3oAmmKnjvlngyMP2HQUK7yk8V2Cw4FDDSmCzUxQjiJ3HoeG3aDNM77YZdT
	TewnMUjGa3Yb/SiF+bXlYyqYgHZVKh0TrMuiAL5YHeZOAvdEAhWcmKCJDZW5ueQvsp3f8OvPRMG
	5TYURN8zvY/Pjl8cnZwWyW1GksZ2VIvPWk0onegUVczcx2+KCi9WLi2VaoHe8DPgBVzcWSQ0TpY
	vagPaphZKjAIYowq0wqxkWR+h6LM/61Siojw4btoApQaTuIwcLjkaW7C8atwncKOrxiIQVIfsnb
	jByN1sv1YmS0dZWsO8UodesKeJpg9Slws4r6pa8/7NKrr0ersVEo0KSAthh9j7j8bUkPxFrQTVq
	wAjbo7Oslq5f6RLKUTwxav7P23BOYuGMw0OTsUBXu5girLxIxS+Xu1sAZHYCPye+/LR3QV4TEPU
	dzG5H+STpZSJccRMk4kFY76ul6mbnVVlRuJeu++WinUnP7KxZMWri5dBqUuJb6bXRgk8tCZjZ8y
	0vrg3ukfAUPTqTmCWw6/BvHKtByjiG1Ya1qWEpFcZWh55+amQoTqBk2JSq8md6kTUMuYABrqsh+
	d3uyqdi6Iiv6pwRZ5zY6wdBxB3wEvNiNwW/+FThMjPbo3p42
X-Received: by 2002:a17:90b:1f86:b0:3ac:7556:8ee0 with SMTP id 98e67ed59e1d1-3b1b0b666c5mr2327587a91.19.1794574853652;
        Fri, 13 Nov 2026 05:00:53 -0800 (PST)
Received: from v4bel ([58.123.110.97])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1b2133c5dsm1761157a91.0.2026.11.13.05.00.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 05:00:52 -0800 (PST)
Date: Fri, 13 Nov 2026 22:00:47 +0900
From: Hyunwoo Kim <imv4bel@gmail.com>
To: David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Richard Gobert <richardbgobert@gmail.com>,
	Willem de Bruijn <willemb@google.com>
Cc: Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org,
	imv4bel@gmail.com
Subject: [PATCH net v2] net: gro: avoid truncating transport header offsets
Message-ID: <avcJ_0-OqgDlD5GB@v4bel>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

skb->transport_header is a 16-bit offset from skb->head, and U16_MAX is
reserved as the unset transport header value. A long IPv6 extension
header chain can make the final offset exceed the field's range.
skb_set_transport_header() then truncates it.

In the UDP reproducer, UDP_GRO is enabled on the receiving socket and
the first packet is held on the GRO list. The truncated offset makes
udp_hdr(p) point to the source MAC address. The first four bytes of the
source MAC address match the UDP source and destination ports, allowing
the second packet in the same flow to pass the port comparison.

gro_receive_network_flush() then derives the first packet's IPv6 header
address from the truncated transport header offset. ipv6_gro_flush()
consequently reads from an address 65,536 bytes before the first packet's
actual IPv6 header. Both UDP and TCP GRO call
gro_receive_network_flush().

KASAN reports:

  BUG: KASAN: use-after-free in udp_gro_receive+0x1f37/0x2680
  Read of size 4 at addr ffff8881065f005e by task swapper/1/0
  ...
  Call Trace:
   <IRQ>
   ...
   udp_gro_receive+0x1f37/0x2680
   udp6_gro_receive+0x23e/0x11d0
   ipv6_gro_receive+0x1200/0x2750
   ...
   dev_gro_receive+0x1a7c/0x2600
   gro_receive_skb+0x271/0x970
   virtnet_receive_done+0x3b5/0x12c0
   receive_buf+0x33a/0x4b40
   ...
   virtnet_poll+0xc69/0x1980
   ...
   __napi_poll+0xa0/0x530
   net_rx_action+0x8ff/0x1280
   ...
   </IRQ>

The out-of-bounds address was in a free page, so KASAN reported a
use-after-free. This classification reflects the state of that page,
not the lifetime of the skb. The invalid read was caused by truncation
of the 16-bit transport header offset.

The IP6_MAX_EXT_HDRS_CNT limit in ipv6_gro_pull_exthdrs() prevents this
reproducer. However, nested encapsulations can each add an extension
header chain, so the accumulated offset can still exceed the range of
skb->transport_header. inet_gro_receive() can also be reached with such
an offset.

Use skb_set_transport_header_careful() in ipv6_gro_receive() and
inet_gro_receive() to validate the final offset before assigning it. If
the offset cannot be represented, the skb is not held as a new GRO head
and is instead delivered through the normal receive path.

This issue was found through AI-based auditing.

Fixes: 4b0ebbca3e16 ("net: gro: move L3 flush checks to tcp_gro_receive and udp_gro_receive_segment")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
---
Changes in v2:
- Base v2 on a tree with Eric's [1] patch applied. (Eric)
- Handle unrepresentable transport header offsets in inet_gro_receive(). (Eric)
- Explain why nested encapsulations still require the checked assignments. (Eric)
- State that the issue was found through AI-based auditing. (Eric)
- Change the subject prefix from ipv6: gro: to net: gro:.
- v1: https://lore.kernel.org/all/avTTQNyvwPP6LtGx@v4bel/
- [1]: https://lore.kernel.org/all/20261113124625.4010206-2-edumazet@kernel.org/
---
 net/ipv4/af_inet.c     | 5 ++++-
 net/ipv6/ip6_offload.c | 3 ++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
index 8822bae439f88d..7db9b52662f6f5 100644
--- a/net/ipv4/af_inet.c
+++ b/net/ipv4/af_inet.c
@@ -1530,7 +1530,10 @@ struct sk_buff *inet_gro_receive(struct list_head *head, struct sk_buff *skb)
 	 * as we already checked checksum over ipv4 header was 0
 	 */
 	skb_gro_pull(skb, sizeof(*iph));
-	skb_set_transport_header(skb, skb_gro_offset(skb));
+	if (!skb_set_transport_header_careful(skb, skb_gro_offset(skb))) {
+		flush = 1;
+		goto out;
+	}
 
 	pp = indirect_call_gro_receive(tcp4_gro_receive, udp4_gro_receive,
 				       ops->callbacks.gro_receive, head, skb);
diff --git a/net/ipv6/ip6_offload.c b/net/ipv6/ip6_offload.c
index 01642900c0fa33..fe38dc15faa67a 100644
--- a/net/ipv6/ip6_offload.c
+++ b/net/ipv6/ip6_offload.c
@@ -249,7 +249,8 @@ INDIRECT_CALLABLE_SCOPE struct sk_buff *ipv6_gro_receive(struct list_head *head,
 		skb_gro_pull(skb, sizeof(*iph));
 	}
 
-	skb_set_transport_header(skb, skb_gro_offset(skb));
+	if (!skb_set_transport_header_careful(skb, skb_gro_offset(skb)))
+		goto out;
 
 	NAPI_GRO_CB(skb)->proto = proto;
 
-- 
2.43.0

