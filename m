Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.70.43.167
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792575361;
	b=qa063uyc0+FVh6Rl8NEw8IzLc/GBjJ5U/NZwudTKsDwsc4sUNF0J8C+U1uVrEWwtUhj4
	 stM6UoRjzBYM8rxWHQ6fxsa9q2azKtZLDG5nCF5OWH/wx0QWv0ollkkpJD0CfuQSLZUAb
	 NDE2qkE2Ed7fnk6cFZjvgck6KBW75VVJ4WDW1xjnwRFuM8We6rdaWAjA5oiVBvPeo2VKD
	 c2dfIFmes6qcFsrlzQ6BVSeZcUxGM83UGEiKCVd4GUyrru94/j7HMdVT+pAC/HWTVziES
	 cpjEhRBJnuz6J5rnsLoRQvL3sIjTT1uvckx1OozKvswDeqPd1BRzWfh9N84CmaDdZNA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792575361;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 Feedback-ID:X-Pm-Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=BTY8n4GtMoPAtOS9wvlY9329TuGyuM1KvhHMnkCsjv0=;
	b=M7HTng9VyV3YYpBTNX5jhxHgYpJceIcbI7UuKeGdYfYelZKqGPd6MYKB3qs26abqBC7i
	 5nApO/qj5qHBuVQ3A9bm1zEfbI2P8y6gyR50SCjli//9IoQ7T0hF0aFC3NUDW+Vp0HnAu
	 KF9y1gi9p0HKYig1XtkAeR3ouLAhwhCfq+/FuTb6p4hkpO6glR0NiXtUDZPd+kjnhInLg
	 W0QCbAk5P3e306PdWszCM5pbz572U//LKQDEGbE9ynuaQdhoPgDBM0Ab1j7rQ/XMbvjWa
	 XdoboSUfGoOCKm5xbqXjSTdP1mZ7NWg2FMAh9+dWdKxqz2ddysOsTg8D+LTpbEdpxPA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=proton.me;
	spf=pass smtp.mailfrom=proton.me;
	dkim=pass header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=protonmail2 header.b="Vj/+hYPO";
	arc=none smtp.remote-ip=185.70.43.167
Received: from mail-43167.protonmail.ch (mail-43167.protonmail.ch [185.70.43.167])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D528606A319
	for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 09:35:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5D528606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=protonmail2 header.b=Vj/+hYPO
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail2; t=1792575357; x=1792834557;
	bh=BTY8n4GtMoPAtOS9wvlY9329TuGyuM1KvhHMnkCsjv0=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=Vj/+hYPOrQ2UUcXkFXbP25FvDF3ubE4E8rLWsHWDUcGs4flA+sgfJfhGWddcegwpO
	 DPrd9DqGlgfvTHViuBfBwC4AEjdT2K/xsBkPz7Asvb+c1o0mAXGoZrPb1xjUJluYy/
	 SgSgQlN4KuaNlFKsDbZiVNiq8eVHWtXxIHuaEUgIwQCE9UyC8+k1dt/6bL91IgRmjI
	 sJtG6WQl9quOHZUGUvdWy217la2ozfkmUWvJjPvq5QoPZxCbGka7rTGYcIpKD6W+bm
	 ckXbsHvPOYtRvocoiPD+1Z2UB4PiQ9mWlf+r7dg+Pd7M/8Bp51jteWNj0wvEvyI1JC
	 faCRAmqfF38QQ==
Date: Wed, 21 Oct 2026 09:35:52 +0000
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
From: omniameasunt@proton.me
Cc: "paul@paul-moore.com" <paul@paul-moore.com>
Subject: [PATCH net] cipso_v4: fail the walk on malformed options
Message-ID: <CBLsHx48w8Bn1k_Xg6kJFliLNkxLCqi8SnkifapxYYpVtll4w-W_2JJePtbk9ssIS701IFJvi0Q2n5l-2GFFe8hNHU9Y_CgD_sdzcAbILVA=@proton.me>
Feedback-ID: 219316618:user:proton
X-Pm-Message-ID: 91b59c001214af969643a27c4c91f908f07cc14c
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

cipso_v4_get_actual_opt_len() walks a compacted IP option buffer with no
validation of the option it is standing on: it reads data[iter + 1]
without checking that the length byte is inside the buffer, it accepts a
zero length byte (spinning forever), and it never clamps the walked
offset to len, so the returned length can exceed the 40-byte MAX_IPOPTLEN
bound that every caller assumes.

After cipso_v4_delopt() memmove-compacts a socket's options, the bytes
past the compacted region are stale and attacker-controlled via
setsockopt(IP_OPTIONS).  An unprivileged user (CAP_NET_RAW in a user
namespace, CIPSO labeling configured) can trigger the walk with
connect(AF_UNSPEC), which reaches cipso_v4_sock_delattr() through the
SELinux NetLabel hook.  The poisoned optlen is later used in
do_ip_getsockopt(), where it causes

  * an out-of-bounds read of the adjacent heap object copied back to
    userspace (kernel pointer disclosure, KASLR defeat), and
  * a stack buffer overflow when optlen exceeds the 56-byte scratch
    buffer (return-address overwrite; exploitable for privilege
    escalation on kernels built without stack protector).

The same helper is also called from cipso_v4_skbuff_delattr() when a
label is removed from output or forwarded packets; the option bytes there
have already been validated by ip_options_compile(), so the new checks
are defensive for that caller.

Fix the defects by making the walk fail with -EINVAL as soon as an
option header is truncated or malformed (length byte missing, zero, or
one) or an option would run past len.  cipso_v4_delopt() then drops the
socket's entire option set (reusing the existing branch that frees the
ip_options_rcu when CIPSO was the only option), and
cipso_v4_skbuff_delattr() leaves a malformed packet unchanged instead
of rewriting its header based on untrustworthy bytes.

Well-formed option streams are unaffected: a socket whose options
survive the compaction intact keeps them; only malformed streams now
lose all options instead of carrying a partially parsed set.

Fixes: 014ab19a69c3 ("selinux: Set socket NetLabel based on connection endp=
oint")
Signed-off-by: Lucas Dupr=C3=A9--Rabinovici <omniameasunt@proton.me>

---
 net/ipv4/cipso_ipv4.c | 22 +++++++++++++++--------
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/net/ipv4/cipso_ipv4.c b/net/ipv4/cipso_ipv4.c
--- a/net/ipv4/cipso_ipv4.c
+++ b/net/ipv4/cipso_ipv4.c
@@ -1824,7 +1824,11 @@
 =09=09} else if (data[iter] =3D=3D IPOPT_NOP) {
 =09=09=09iter++;
 =09=09} else {
+=09=09=09if (iter + 1 >=3D len || data[iter + 1] < 2)
+=09=09=09=09return -EINVAL;
 =09=09=09iter +=3D data[iter + 1];
+=09=09=09if (iter > len)
+=09=09=09=09return -EINVAL;
 =09=09=09optlen =3D iter;
 =09=09}
 =09}
@@ -2028,6 +2032,13 @@
=20
 =09=09optlen_new =3D cipso_v4_get_actual_opt_len(opt->opt.__data,
 =09=09=09=09=09=09=09 opt->opt.optlen);
+=09=09if (optlen_new < 0) {
+=09=09=09/* malformed option stream, drop all the options */
+=09=09=09*opt_ptr =3D NULL;
+=09=09=09hdr_delta =3D opt->opt.optlen;
+=09=09=09kfree_rcu(opt, rcu);
+=09=09=09return hdr_delta;
+=09=09}
 =09=09hdr_delta =3D opt->opt.optlen;
 =09=09opt->opt.optlen =3D (optlen_new + 3) & ~3;
 =09=09hdr_delta -=3D opt->opt.optlen;
@@ -2249,7 +2260,7 @@
 int cipso_v4_skbuff_delattr(struct sk_buff *skb)
 {
 =09int ret_val, cipso_len, hdr_len_actual, new_hdr_len_actual, new_hdr_len=
,
-=09    hdr_len_delta;
+=09    hdr_len_delta, optlen;
 =09struct iphdr *iph;
 =09struct ip_options *opt =3D &IPCB(skb)->opt;
 =09unsigned char *cipso_ptr;
@@ -2266,9 +2277,12 @@
 =09cipso_ptr =3D (unsigned char *)iph + opt->cipso;
 =09cipso_len =3D cipso_ptr[1];
=20
-=09hdr_len_actual =3D sizeof(struct iphdr) +
-=09=09=09 cipso_v4_get_actual_opt_len((unsigned char *)(iph + 1),
-=09=09=09=09=09=09     opt->optlen);
+=09optlen =3D cipso_v4_get_actual_opt_len((unsigned char *)(iph + 1),
+=09=09=09=09=09     opt->optlen);
+=09/* malformed option stream, leave the packet unchanged */
+=09if (optlen < 0)
+=09=09return -EINVAL;
+=09hdr_len_actual =3D sizeof(struct iphdr) + optlen;
 =09new_hdr_len_actual =3D hdr_len_actual - cipso_len;
 =09new_hdr_len =3D (new_hdr_len_actual + 3) & ~3;
 =09hdr_len_delta =3D (iph->ihl << 2) - new_hdr_len;

