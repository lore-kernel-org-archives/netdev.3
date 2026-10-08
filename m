Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B2024B8DE2
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 15:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791473307; cv=none; b=Hb/mtpZ7IdTGJ2OQ4a3x7GnAfwFNduaNmDjgQTrdOjdUnjTBNOXesvhDLWDDRec3fNxNr95bsRZL1scX/duUhgfutzggu0UyHsARyVoxFrD8HNUf7qxVqfPBNsRoDn3/ggzuDrI1iwoWclZwT1BlphCCWjAIpk96GR7UsoXGCdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791473307; c=relaxed/simple;
	bh=lw5jMw8GbgxjgStIOv5agiUnsCdhb70l60n5F3OPbo0=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=eWKSwPi4pXjTKTXn9Pee+09Nm8HN41DFLN2I0uX1pnXe4tS1awtNF0LElPHtRBfqgtzvbf0RcTw1nXUUgkVoES/n62+tYUy9pX1Ids34wuVAf0XjAPkq9lvNR2FnPJh2LAM994hdZPiOCgwua7/DQec9ICSiVOoLWTE4fwHy2OQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G9/Wa0m8; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G9/Wa0m8"
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-6dde81a6820so4133975eaf.2
        for <netdev@vger.kernel.org>; Thu, 08 Oct 2026 08:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791473302; x=1792078102; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:content-type:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=E00L9X2RHgWS9tfvtGx8xYe4bHrJKbfrkDRJPi5o0Gg=;
        b=G9/Wa0m8qHYYu+BwCOyZTdgL57n/aqb9Pczg+nf1CdeTf995HU2eKh72OL5A6d+bAm
         RzCh3oOGitPvmLIwadbbTWXOQhMAFpSv3chwvSVhQoZSUtgMj1DKmDN1GnWsPE9ViL8e
         BX/zGX9qN5I0drATpW8ByebE55ysgMa6Z2Zhs3dNxlJZmKNOYCFNJ20Z8hRr7A1BOrJf
         gDQ+OpZJQaNej61Lj81xIbjHgWpDgsQC96WQFiqAS6GXS6UZuxxfZzvJpj5y++Jgd6TU
         jYdbn4mge9HNXSL02Hk2dn61ZFSv9loIg/MyDLrgqWwJWB8f+/LdN0MfndUxKw4zD8XM
         8YcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791473302; x=1792078102;
        h=mime-version:content-transfer-encoding:content-type:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=E00L9X2RHgWS9tfvtGx8xYe4bHrJKbfrkDRJPi5o0Gg=;
        b=rMYLSrLTJ0mWLiA0afjtkrSRy44McEzHFrPxcta1cePCrPNq5Z4PevrQY1/fSz4apt
         ilYhQwW1Zy+7QxF+s/mNUZsfPLf7Pp/DqtMu4ra128G8cDuFL284IlcAAcwWLxjKCtF0
         FyDIh+8YFWji6tgX23cBX//JnkkbyqD6vE4KXRRdlKPN993L4vNNQZfVYODOZDM3h+sL
         OWwBw+odb5aU7Yamf8ve1Z4yKIelaS5rr/uC3Qg4VyuEZRIKgoeKcGe6sjEsc8YGYRG1
         3Q2wZ8Ed6ChkGUr6Z2kUfQ7tSWNG6zpq5keCQSBA2ld+LpdDFcbktfiGh4MPGwJ0/uIW
         6GuA==
X-Forwarded-Encrypted: i=1; AKwUvBwN6iTDutFU34F4AR0Ug+/eeKYkbE2OhPUBCan5jLDqwVj12Mcn6K4Ito6WWCvQsUL9/5BAMiE=@vger.kernel.org
X-Gm-Message-State: AFuF++lG18Xjf5nKlnJv5HOEqYuV1yAs7a24zCY6+2zQ6/Hn5+KyhEBW
	j8FBK3vtHRP+nMqtWoS70Uax2FyDcKfc0qC8NlFfSHC7eCBP0851N4VW
X-Gm-Gg: AYBFou3jP6epZtOELfpxROmEN/hlaUch6DddqUIJvH5qbIPE0IkpV2PEoCn+v1/MHbk
	a3tom69H4AVsui5l9AUiKPMZuZ1scf/57x6ioOUNrthB0WHtrxgvVTIWkLjXat9AebtNNjLeYaC
	UqQU4+trfRslG5aMHtOeYJfBUw7vnY+TvLKlrciDr1fjcHo1aSxkiPS9ltvmaItt148oUCGvRn/
	wQpdKWrHBNKzN8JHsg5WCYiidKy4fHuHGtU0p/OoBYXOHdDNqPi17zS1NujeOhoRjszyChQdwkp
	2BXeJfmvLXTP/+7YR4wLc6VRqdNp5EpSBcbTLEYTuIjj6d4/ALPrZAUNxfQgTyR7WZg9bc2iNNH
	TlZ6/FhLo7aJZpGakXoN/6ABWrZdzu9xB9lL/SCdTqj0QNIBggy3AGsxB86EG/z0toaYL4dbRa/
	BtNw2HIdRC1QSBulpk4dwhk46/Locb8uPoUGlD/QKHMmv7vOD2rheng9OotBpCuIt5DjRQhVbE3
	qq7y0xM8iueHk+4wegq8kkYqQvvjHixNLt2vUPSdjzVrqSNAWGlDs2H35p5eabzMUk9r+fZNCg2
	tqTKGlmQlSY2tCTOnIgjv0lCV0ypboAq3JZELiFWA8zl/TfBqa+qzJ30SN371GybCS9FsjE=
X-Received: by 2002:a05:6820:f005:b0:6d8:5491:3753 with SMTP id 006d021491bc7-6e7a60b74a6mr5264621eaf.45.1791473302362;
        Thu, 08 Oct 2026 08:28:22 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([2804:7f0:b100:655c:c517:c6a0:13b2:a6e1])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6e79392d23fsm4265764eaf.6.2026.10.08.08.28.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 08:28:21 -0700 (PDT)
From: Joas Antonio dos Santos <joasantonio108@gmail.com>
To: Paul Moore <paul@paul-moore.com>
Cc: Eric Dumazet <edumazet@kernel.org>, David S. Miller <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
 linux-security-module@vger.kernel.org, alice.kernel@fastmail.im
Subject:
 [PATCH net v2] calipso: update payload_len when removing the CALIPSO option
Date: Thu, 08 Oct 2026 12:28:12 -0300
Message-ID: <179147329205.58079.5847298721173675285@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

calipso_skbuff_delattr() removes the CALIPSO option from the hop-by-hop
extension header, or the whole extension header if CALIPSO is its only
option, and pulls the skb by the removed length.  It never updates
ipv6hdr->payload_len, so after a successful removal the header still
claims the original length.

calipso_skbuff_setattr() already adjusts payload_len by the length it
adds; the delete path was missed.

This is reached on the forward path when a packet carrying CALIPSO is
sent to a destination mapped to an unlabeled NetLabel domain.  The
forwarded packet then has a payload_len larger than its real payload
by the removed length (8 to 264 bytes), and the receiver drops it as
truncated.  So removing the label on the forward path has been broken
for every packet that is not resegmented later (SYN, UDP, ICMPv6...).

Adjust payload_len after the header is moved.  BIG TCP packets carry
payload_len == 0 (see ipv6_set_payload_len()), and ipv6_payload_len()
then falls back to skb->len, so leave them alone.

Tested with client, router and server network namespaces on one kernel
(arm64, QEMU): SELinux permissive with a minimal mdp-generated policy
(network_peer_controls=1), "netlabelctl calipso add pass doi:16", the
default NetLabel mapping left unlabeled, IPv6 forwarding on the router.
The client sends 5 UDP datagrams with a CALIPSO hop-by-hop option
(DOI 16, set through IPV6_HOPOPTS) to the server through the router:

  before: router Ip6OutForwDatagrams 5, server receives 0,
          server Ip6InTruncatedPkts 5
  after:  router Ip6OutForwDatagrams 5, server receives 5,
          server Ip6InTruncatedPkts 0

Fixes: 2917f57b6bc1 ("calipso: Allow the lsm to label the skbuff directly.")
Signed-off-by: Joas Antonio dos Santos <joasantonio108@gmail.com>
Assisted-by: Claude:claude-opus-5-5
---
Changes in v2:
- Skip the adjustment for BIG TCP packets (payload_len == 0), as
  suggested by Eric Dumazet.
- Exercised the forward path and described the test in the changelog.
- calipso_skbuff_setattr() has the same BIG TCP issue with its
  htons(payload + len_delta); I will send that as a separate patch.

Reproducer for the forward test (as run on 602042bf29f6, arm64, QEMU,
CONFIG_SECURITY_SELINUX=y, CONFIG_NETLABEL=y, CONFIG_IPV6=y):

  # minimal policy from the kernel tree; an older checkpolicy may need
  # all policycap lines except network_peer_controls removed
  # scripts/selinux/mdp/mdp is built by 'make' with SELinux enabled
  scripts/selinux/mdp/mdp -m policy.conf file_contexts
  checkpolicy -U allow -M -o policy.33 policy.conf

  # boot with lsm=selinux enforcing=0, then:
  cat policy.33 > /sys/fs/selinux/load
  netlabelctl calipso add pass doi:16     # default mapping stays unlabeled

  ip netns add C; ip netns add R; ip netns add S
  ip link add cr type veth peer name rc
  ip link add rs type veth peer name sr
  ip link set cr netns C; ip link set rc netns R
  ip link set rs netns R; ip link set sr netns S
  ip -n C -6 addr add fd00:1::2/64 dev cr nodad; ip -n C link set cr up
  ip -n R -6 addr add fd00:1::1/64 dev rc nodad; ip -n R link set rc up
  ip -n R -6 addr add fd00:2::1/64 dev rs nodad; ip -n R link set rs up
  ip -n S -6 addr add fd00:2::2/64 dev sr nodad; ip -n S link set sr up
  ip -n C -6 route add default via fd00:1::1
  ip -n S -6 route add default via fd00:2::1
  ip netns exec R sh -c 'echo 1 > /proc/sys/net/ipv6/conf/all/forwarding'

  # a UDP listener on [::]:9999 in S (I used a small recv loop)
  ip netns exec C ./calsend fd00:2::2
  ip netns exec S grep -E 'Ip6InTruncatedPkts|Udp6InDatagrams' /proc/net/snmp6

calsend.c (UDP with a CALIPSO hop-by-hop option, DOI 16, valid CRC):

  /* Send UDP datagrams carrying a CALIPSO hop-by-hop option (DOI 16,
   * level 0, no categories) with a valid CRC. */
  #include <arpa/inet.h>
  #include <netinet/in.h>
  #include <stdint.h>
  #include <stdio.h>
  #include <string.h>
  #include <sys/socket.h>
  #include <unistd.h>

  static uint16_t crc_ccitt(uint16_t crc, const uint8_t *p, size_t len)
  {
  	while (len--) {
  		crc ^= *p++;
  		for (int i = 0; i < 8; i++)
  			crc = (crc & 1) ? (crc >> 1) ^ 0x8408 : crc >> 1;
  	}
  	return crc;
  }

  int main(int argc, char **argv)
  {
  	uint8_t hop[16] = {
  		0, 1,			/* next header (set by kernel), len 16 */
  		0x07, 8,		/* CALIPSO, option data length 8 */
  		0, 0, 0, 16,		/* DOI 16 */
  		0,			/* compartment length */
  		0,			/* sensitivity level */
  		0, 0,			/* CRC */
  		1, 2, 0, 0,		/* PadN */
  	};
  	uint8_t *opt = hop + 2;
  	uint16_t crc = ~crc_ccitt(0xffff, opt, 10);

  	opt[8] = crc & 0xff;
  	opt[9] = crc >> 8;

  	struct sockaddr_in6 a = { .sin6_family = AF_INET6, .sin6_port = htons(9999) };
  	inet_pton(AF_INET6, argv[1], &a.sin6_addr);
  	int s = socket(AF_INET6, SOCK_DGRAM, 0);
  	if (setsockopt(s, IPPROTO_IPV6, IPV6_HOPOPTS, hop, sizeof(hop))) {
  		perror("IPV6_HOPOPTS");
  		return 1;
  	}
  	for (int i = 0; i < 5; i++) {
  		sendto(s, "calipso", 7, 0, (void *)&a, sizeof(a));
  		usleep(200000);
  	}
  	printf("CALTEST: sent 5 UDP datagrams with CALIPSO to %s\n", argv[1]);
  	return 0;
  }

 net/ipv6/calipso.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/ipv6/calipso.c b/net/ipv6/calipso.c
index c6a34334e..5a42db4f8 100644
--- a/net/ipv6/calipso.c
+++ b/net/ipv6/calipso.c
@@ -1428,6 +1428,10 @@ static int calipso_skbuff_delattr(struct sk_buff *skb)
 		skb_pull(skb, delta);
 		memmove((char *)ip6_hdr + delta, ip6_hdr, size);
 		skb_reset_network_header(skb);
+		ip6_hdr = ipv6_hdr(skb);
+		/* BIG TCP packets have payload_len == 0 */
+		if (ip6_hdr->payload_len)
+			be16_add_cpu(&ip6_hdr->payload_len, -delta);
 	}
 
 	return 0;
-- 
2.43.0

