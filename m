Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=79.135.106.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793099814;
	b=LXAWbCh8tsojLwOIVAHG4hqwCBVWQe3qXM2SjTKN8ixeVEzuQ5W9iRN5tePDCiDucnP6
	 +ElMLDOGEzHn30fv1DrIYbSnfrUVEPNO+phPs6Z9eI5liJQmB9iKPbqVeOeeK63eaCHj1
	 vIhMeMku8N2xGOXLef1hn/8v9/wWSZD/+AsktOcztGJ2h3NAjm99+Rhtg83qMiCaJgtHH
	 jGYiycELMTnvKs2WGTAx4QrWpjrhMSna0jpsRy/4CkjhJG1ECKoWBfApwUaoutpxiyUTQ
	 exF/ztslXL2aHeZeRyN2MO6WbvI8C5Zl+OMQ4EBxISJTCZ5uy0tE7AaTQ5KYDhnDd5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793099814;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 Feedback-ID:X-Pm-Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=4e/ijGid9rqc5SgoybakUdWyi0vXdqYvSUZK3BN12UM=;
	b=ghMAV+LFyRG+7Pc4d1rNIfRQRyBywgH/aurtwRB04p0GlQ61Md9TBu+dwLmnsBSN5u0I
	 tL8RqqwPDBnl7/LkSLHd/ZXLe4H8lc5Tapdu356PKSfgRNu+DIq/MQr7C7Z+IM46RAPXs
	 l6sYSROumWH2Gegq9AgOGRyFnJ++2ds8oM+WAUnd/G9NtiUDL3upLS6T4QZKYgww10rx9
	 bzdYUWJfqemcuH0ohWGu6dXUZ66Nb4VbHIeP7eDER9aR7no8tWFL7gvd6XnAvY+6lv5iD
	 tfVjg99RE3BTNTxPKmHfml65HlXq0NjiFSYhgNuhWbUivII1nyD5FzbCUyjw8Gki47w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=proton.me;
	spf=pass smtp.mailfrom=proton.me;
	dkim=pass header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=protonmail2 header.b=lNWF3+MR;
	arc=none smtp.remote-ip=79.135.106.101
Received: from mail-106101.protonmail.ch (mail-106101.protonmail.ch [79.135.106.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AAFC606A31B
	for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 11:16:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2AAFC606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=protonmail2 header.b=lNWF3+MR
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail2; t=1793099810; x=1793359010;
	bh=4e/ijGid9rqc5SgoybakUdWyi0vXdqYvSUZK3BN12UM=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=lNWF3+MR5sLECC4JQlckLBtL+WL4mvPKwdqJ0UgMscASIaGKRpCvQHPuiM4w6GRYj
	 nemmKqlDqJKH9JeUZucx9/gGYzm6dJON4jO13jz9iP2s04u8vOs9gcm4EC76f0VejP
	 lFbAVlvTycW59jSQU1x+yfkBQz6tReaMh5l79RMDm3S+bh/XnGz4ddDu0LK2YAiExS
	 R8gp2P3fFmqUuBHxIpXno74ehAE+zQEWzSmF5qHHmoFtdL18hZUkjRW9daKx6MG4Id
	 qrKb2jJ9HucbdzO4In/BncDMVbyotX3MISBQT6mLa3gLPO8tpcReknjwG7SzkLA6D/
	 iWyAg9H9AE0jw==
Date: Tue, 27 Oct 2026 11:16:46 +0000
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
From: omniameasunt@proton.me
Cc: Paul Moore <paul@paul-moore.com>
Subject: [PATCH net v2] cipso_v4: fail the walk on malformed options
Message-ID: <uOcTaW7-g5e97ng6BG_DcH5mlMnpw7KzU25SZjL69pkAVINTMiL26FryLAuYPSNowDo8qwfb9hm_I4dQ1BwpiRe62E-I2TyUkJZ_eBeuLoo=@proton.me>
Feedback-ID: 219316618:user:proton
X-Pm-Message-ID: 5b9968d5edb6bce6b1f90add939ee14d7fc34066
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
  * a stack buffer overflow when optlen exceeds the 60-byte scratch
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

The function also compacted the option object in place while the
ip_options_rcu remained published.  Lockless readers such as
getsockopt(IP_OPTIONS), UDP sendmsg(), raw sendmsg(), and ping sendmsg()
copy the object under rcu_read_lock(), so they can observe a mixture of
old and new offsets or option bytes.  Build the compacted object in a
replacement ip_options_rcu, modify only the replacement, publish it with
rcu_assign_pointer(), and retire the old object with kfree_rcu().  If the
replacement cannot be allocated, leave the old object untouched and
return -ENOMEM.

Fixes: 014ab19a69c3 ("selinux: Set socket NetLabel based on connection endp=
oint")
Signed-off-by: Lucas Dupr=C3=A9--Rabinovici <omniameasunt@proton.me>
---
Previous version:
https://lore.kernel.org/netdev/CBLsHx48w8Bn1k_Xg6kJFliLNkxLCqi8SnkifapxYYpV=
tll4w-W_2JJePtbk9ssIS701IFJvi0Q2n5l-2GFFe8hNHU9Y_CgD_sdzcAbILVA=3D@proton.m=
e/

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
@@ -1992,53 +1996,79 @@
  *
  * Description:
  * Deletes the CIPSO IP option from a set of IP options and makes the nece=
ssary
- * adjustments to the IP option structure.  Returns zero on success, negat=
ive
- * values on failure.
+ * adjustments to the IP option structure.  Returns zero or a positive hea=
der
+ * length delta on success, negative values on failure.
  *
  */
 static int cipso_v4_delopt(struct ip_options_rcu __rcu **opt_ptr)
 {
 =09struct ip_options_rcu *opt =3D rcu_dereference_protected(*opt_ptr, 1);
+=09struct ip_options_rcu *new;
 =09int hdr_delta =3D 0;
+=09u8 cipso_len, cipso_off;
+=09unsigned char *cipso_ptr;
+=09int optlen, optlen_new;
=20
 =09if (!opt || opt->opt.cipso =3D=3D 0)
 =09=09return 0;
-=09if (opt->opt.srr || opt->opt.rr || opt->opt.ts || opt->opt.router_alert=
) {
-=09=09u8 cipso_len;
-=09=09u8 cipso_off;
-=09=09unsigned char *cipso_ptr;
-=09=09int optlen_new;
-
-=09=09cipso_off =3D opt->opt.cipso - sizeof(struct iphdr);
-=09=09cipso_ptr =3D &opt->opt.__data[cipso_off];
-=09=09cipso_len =3D cipso_ptr[1];
-
-=09=09if (opt->opt.srr > opt->opt.cipso)
-=09=09=09opt->opt.srr -=3D cipso_len;
-=09=09if (opt->opt.rr > opt->opt.cipso)
-=09=09=09opt->opt.rr -=3D cipso_len;
-=09=09if (opt->opt.ts > opt->opt.cipso)
-=09=09=09opt->opt.ts -=3D cipso_len;
-=09=09if (opt->opt.router_alert > opt->opt.cipso)
-=09=09=09opt->opt.router_alert -=3D cipso_len;
-=09=09opt->opt.cipso =3D 0;
=20
-=09=09memmove(cipso_ptr, cipso_ptr + cipso_len,
-=09=09=09opt->opt.optlen - cipso_off - cipso_len);
-
-=09=09optlen_new =3D cipso_v4_get_actual_opt_len(opt->opt.__data,
-=09=09=09=09=09=09=09 opt->opt.optlen);
-=09=09hdr_delta =3D opt->opt.optlen;
-=09=09opt->opt.optlen =3D (optlen_new + 3) & ~3;
-=09=09hdr_delta -=3D opt->opt.optlen;
-=09} else {
+=09if (!opt->opt.srr && !opt->opt.rr && !opt->opt.ts &&
+=09    !opt->opt.router_alert) {
 =09=09/* only the cipso option was present on the socket so we can
 =09=09 * remove the entire option struct */
-=09=09*opt_ptr =3D NULL;
+=09=09rcu_assign_pointer(*opt_ptr, NULL);
 =09=09hdr_delta =3D opt->opt.optlen;
 =09=09kfree_rcu(opt, rcu);
+=09=09return hdr_delta;
 =09}
=20
+=09new =3D kzalloc(sizeof(*new) + opt->opt.optlen, GFP_ATOMIC);
+=09if (!new)
+=09=09return -ENOMEM;
+=09memcpy(&new->opt, &opt->opt, sizeof(new->opt) + opt->opt.optlen);
+
+=09cipso_off =3D new->opt.cipso - sizeof(struct iphdr);
+=09if (cipso_off + 1 >=3D new->opt.optlen)
+=09=09goto drop_all;
+=09cipso_ptr =3D &new->opt.__data[cipso_off];
+=09cipso_len =3D cipso_ptr[1];
+=09if (cipso_len < 2 || cipso_len > new->opt.optlen - cipso_off)
+=09=09goto drop_all;
+
+=09if (new->opt.srr > new->opt.cipso)
+=09=09new->opt.srr -=3D cipso_len;
+=09if (new->opt.rr > new->opt.cipso)
+=09=09new->opt.rr -=3D cipso_len;
+=09if (new->opt.ts > new->opt.cipso)
+=09=09new->opt.ts -=3D cipso_len;
+=09if (new->opt.router_alert > new->opt.cipso)
+=09=09new->opt.router_alert -=3D cipso_len;
+=09new->opt.cipso =3D 0;
+
+=09memmove(cipso_ptr, cipso_ptr + cipso_len,
+=09=09new->opt.optlen - cipso_off - cipso_len);
+
+=09/* Only the compacted region is live.  The old tail is stale and
+=09 * must not take part in the walk or remain visible as IP options.
+=09 */
+=09optlen =3D new->opt.optlen - cipso_len;
+=09memset(new->opt.__data + optlen, IPOPT_END, cipso_len);
+=09optlen_new =3D cipso_v4_get_actual_opt_len(new->opt.__data, optlen);
+=09if (optlen_new < 0)
+=09=09goto drop_all;
+
+=09hdr_delta =3D opt->opt.optlen;
+=09new->opt.optlen =3D (optlen_new + 3) & ~3;
+=09hdr_delta -=3D new->opt.optlen;
+=09rcu_assign_pointer(*opt_ptr, new);
+=09kfree_rcu(opt, rcu);
+=09return hdr_delta;
+
+drop_all:
+=09kfree(new);
+=09rcu_assign_pointer(*opt_ptr, NULL);
+=09hdr_delta =3D opt->opt.optlen;
+=09kfree_rcu(opt, rcu);
 =09return hdr_delta;
 }
=20
@@ -2248,14 +2278,18 @@
  */
 int cipso_v4_skbuff_delattr(struct sk_buff *skb)
 {
-=09int ret_val, cipso_len, hdr_len_actual, new_hdr_len_actual, new_hdr_len=
,
-=09    hdr_len_delta;
+=09int ret_val, cipso_len, cipso_off, hdr_len_actual, new_hdr_len_actual;
+=09int new_hdr_len, hdr_len_delta, optlen;
 =09struct iphdr *iph;
 =09struct ip_options *opt =3D &IPCB(skb)->opt;
 =09unsigned char *cipso_ptr;
=20
 =09if (opt->cipso =3D=3D 0)
 =09=09return 0;
+=09if (opt->cipso < sizeof(struct iphdr) ||
+=09    opt->cipso - sizeof(struct iphdr) + 1 >=3D opt->optlen)
+=09=09return -EINVAL;
+=09cipso_off =3D opt->cipso - sizeof(struct iphdr);
=20
 =09/* since we are changing the packet we should make a copy */
 =09ret_val =3D skb_cow(skb, skb_headroom(skb));
@@ -2263,12 +2297,19 @@
 =09=09return ret_val;
=20
 =09iph =3D ip_hdr(skb);
+=09if (opt->optlen > (iph->ihl << 2) - sizeof(struct iphdr))
+=09=09return -EINVAL;
 =09cipso_ptr =3D (unsigned char *)iph + opt->cipso;
 =09cipso_len =3D cipso_ptr[1];
+=09if (cipso_len < 2 || cipso_len > opt->optlen - cipso_off)
+=09=09return -EINVAL;
=20
-=09hdr_len_actual =3D sizeof(struct iphdr) +
-=09=09=09 cipso_v4_get_actual_opt_len((unsigned char *)(iph + 1),
-=09=09=09=09=09=09     opt->optlen);
+=09optlen =3D cipso_v4_get_actual_opt_len((unsigned char *)(iph + 1),
+=09=09=09=09=09     opt->optlen);
+=09/* malformed option stream, leave the packet unchanged */
+=09if (optlen < 0 || cipso_off + cipso_len > optlen)
+=09=09return -EINVAL;
+=09hdr_len_actual =3D sizeof(struct iphdr) + optlen;
 =09new_hdr_len_actual =3D hdr_len_actual - cipso_len;
 =09new_hdr_len =3D (new_hdr_len_actual + 3) & ~3;
 =09hdr_len_delta =3D (iph->ihl << 2) - new_hdr_len;

