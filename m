Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62997243956
	for <netdev@vger.kernel.org>; Wed,  2 Sep 2026 06:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788330146; cv=pass; b=ckhjbKuy/gHQkgLSKNWVOvb7APSvUZ875MbKmoQndyS67TyVez0KSGz+sMB/DPiJNAYy4ASP8zYeBaRb5a/hEmX3YMiUAZVWw5ISuAK8RCPD8p1PFGbbLe2Zh3ur4mybSLdWsCx+tfqk4brahW4vzMBkv64vfpJQW1x/V8F4fKU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788330146; c=relaxed/simple;
	bh=QKMQ5dHezzhS6pTrT5Fc0VtyBmq25vWVQLGbFsQzLfE=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=chom+1gQE1FXC6nkxRLWkWIr+EglRjT/SXfnDqlAZG/LgS9xTlyvZCYHfsSAwy3J3zVezovquOba3QAZt88ejvgS3L/R5E7p2LuSoGn9S9PbRbJRO2koDBCq9b3ENgrGDrD/HqyeiYk4UiLUqfa//HONcNVrSVsCgjbkBLMPXIE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JvdXBGwK; arc=pass smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JvdXBGwK"
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-7f6617c7536so299186a34.1
        for <netdev@vger.kernel.org>; Tue, 01 Sep 2026 23:22:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788330144; cv=none;
        d=google.com; s=arc-20260327;
        b=jYYiBsLHTD0vWpED0d5vhcjOgm35zIYHPC+HAPEQ/d4M7FxeNhGoHWsmDgFzrT9g+q
         S8O0AhkGsIRsH//jnjGQBzO66/3xPqA/+suSLinWq1mpq1DAms3ivtjSjNGa2Esy5f+7
         V0e0YjHPpIaCSLikQqw8+zreZKcSSn9F18VhtbXrMv4mqY/qu1FHgUGKcnKUZPoQ/5mb
         z6+PJlbdZ/9vJxf4kRiWFvHXtY6bYWlSYT40IpYNC38sqAheQX2bBUA1/iK93lMDGJWC
         9JcwFXgy235D0r2khP9dCgWI3VFlHlPVpcs7deKphs4qNQ1cQZIWyyfZlvUciBkSnSfT
         ifFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=795V3NV/mTfuqSi46PUPwGaDSWJU6xx+88+WjSOianI=;
        fh=/N6/B5Ja8/YeKc6nY8zIrCsCtF6Jkup9vdomJIxTcHU=;
        b=YXYUoZDLs66Vy0Q+K5DAi5Ud+HxBdDq0OYGu86/FrIunVroP7KQqWwjuV66NpAF9x9
         TX3vxc2OVZ6/COrLnYjogVBvz9z88bCDxJfE/BXJocPQqwl1TVr5oC/50yoSkut2Xm8L
         vjXkSjQ4Wwjk5xHcmyI3c0G7sCQlXvFGE7vTbouo7RdC9PVrEfrfFNa1+BAqco0SPRh5
         EmDVXlepIFGnyfz4jRj6QCeAH1QwWcil+gffKflNEOM8ZNa89gV/Hu7xIG8AufilAdFT
         NCFm3vlMwH5ZuP+UhiHdglXctC20kgsfIbgVUhu5MPxMJiseA0QmX+Gvkk3U1YXJ8gOI
         pIFw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788330144; x=1788934944; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=795V3NV/mTfuqSi46PUPwGaDSWJU6xx+88+WjSOianI=;
        b=JvdXBGwKFYWYjt03PrXWe5A8h12WUD0UuoOefGmnwZKFGSqAf2ZDjEU8hdW5X1J9HA
         PbgdAaNVbeZr4pXmkqHAdjXlAa0R3TgNuueh+eyhV0AaQK5p+NXry7xGR0le+NMPsZM8
         sqGPSkaYPQuDiii55KgyYnwISNPLMmQLbJ5zbnXSC68LBO3weKAQ6+C6znx1RjSC8n01
         FhjdZ4+0iIkD/ExteKYt7p0o+UBou8pZtwUs+fQ+jngMghvt0eB8o2qfHOhm2tZP0aiD
         fZMFYBivz3ELuokgLRbvDZas6HCfhdaOaM92RptffYHg9LtesBJojX0viW9PfTBqOPYO
         ErEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788330144; x=1788934944;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=795V3NV/mTfuqSi46PUPwGaDSWJU6xx+88+WjSOianI=;
        b=nhAtzp0LVOMW7h+sXxXYii9gZO+CTtZKTdSjRkpAI//3lgUwhcM1zN0rtCp7vDE6Sf
         FCkudSx4ezpzPrDgBthljuYGFAAU4e0RUYl9kn5wO5u+O/Fsndei54uQ3EZnZsLYE4Ta
         e4H0M5MrYkgATgsuq2A0nX7wWoPmZjF8GglHwwtzHcukftn/lz0BRkdt9hKPDBJHi3OL
         0ZFH7tTdi7cgkqPTQDRX8DMnYqTouZ7Bi11SkBTUaMQiuwbdqzISsuiE4Aed2hYKgtUY
         1psjDDL+COeKquDXKM2tfkJ86iqEB03/YDn0wTml963ydNUc+m7MceGRqz019bCtCWVg
         PhfQ==
X-Forwarded-Encrypted: i=1; AHgh+RqYyfNqVV4jopK5p2LrTEmrfmao9BriofqK1EGiYxj5A6V+xgtE5QQDi4oHjrLz2lMHA3uREgY=@vger.kernel.org
X-Gm-Message-State: AFuF++k0YckrYjDxqf20KCcOgBgJlPaPJy6VGWudeG2ysLciXpQITYXG
	OgQVDrBg9O6mx+IHleCNSubFkSgFMNCthIHEgrmWjlDyFzxZsV0jrrXciUPJq9WNwc15u/uRmCy
	2Lu3ShOAAUuKcFAfL8iAL/b/c7VMRZ/CbdLz+
X-Gm-Gg: AR+sD12J/bMzHdy9Bvn55fmABA+WjS5utKU/aO5RqZboq13UARjlLX3tXrD89OcCdUU
	BeO1L5THYK1j2hwVYMyu2bLyqeQ3rKXfLt4LNejwMFcNdICQsEIK+SqJtM7u2g6UUuvBq2RAK9j
	PMSArkEzqZzwJNrNhk1/loge8uvPjoWmQGUtQRNNOR/lNhd30f14UBBYKA7cvQ4Ro/OefBJKVnj
	Q/yv7CM+ZaVAdqSFTzkptx1UFIps7CA1sX4jlIZmKG13tmk62jiRwerxJK0UJI6KY2d3RealQYV
	QRoywXjGH/mnOwV6QTs/AT/DjEGjLc3UE5wBG3yXGnlxNWEKgOo1vE2PHoybCsR4/PgDfpnfnjk
	PGfE=
X-Received: by 2002:a05:6820:f013:b0:6b1:fe93:3a69 with SMTP id
 006d021491bc7-6b47fb291fbmr1734024eaf.24.1788330144185; Tue, 01 Sep 2026
 23:22:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Vlatko Kosturjak <vlatko.kosturjak@gmail.com>
Date: Wed, 2 Sep 2026 08:22:11 +0200
X-Gm-Features: AcwNN1U6cvQzdu6HmjaYgagybI0ypFR99JGBNm4JU6mEqyIYfN3BpM3oFl7I864
Message-ID: <CAPAw8HE6QgnePG=UUfU2d9mYXNpY2O_kp5v0J82VuVoR6gwWOg@mail.gmail.com>
Subject: [PATCH] ppp: make room for the filter tag instead of assuming it
To: linux-ppp@vger.kernel.org, netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Content-Type: multipart/mixed; boundary="000000000000fc8771065a7a0e5e"

--000000000000fc8771065a7a0e5e
Content-Type: text/plain; charset="UTF-8"

ppp_receive_nonmp_frame() prepends a two-byte direction tag before running
the pass/active BPF filters:

        *(__be16 *)skb_push(skb, 2) = htons(PPP_FILTER_INBOUND_TAG);

Nothing on the receive path guarantees those two bytes of headroom, and a
peer can arrange for only one to be available. ppp_async.c contributes two
halves of the problem.

First, the frame-error path resets a reused skb's headroom to zero while
claiming to restore it to a freshly allocated state - but a fresh skb from
dev_alloc_skb() carries NET_SKB_PAD:

        err:
                if (skb) {
                        /* make skb appear as freshly allocated */
                        skb_trim(skb, 0);
                        skb_reserve(skb, - skb_headroom(skb));
                }

ap->rpkt still points at that skb, so the next frame reuses it with no
headroom at all.

Second, the headroom for a new frame is chosen from a single byte, and the
comment already notes the test is incomplete:

        if (skb->len == 0) {
                /* Try to get the payload 4-byte aligned. This should match
                 * the PPP_ALLSTATIONS/PPP_UI/compressed tests in
                 * process_input_packet, but we do not have enough chars here
                 * to test buf[1] and buf[2].
                 */
                if (buf[0] != PPP_ALLSTATIONS)
                        skb_reserve(skb, 2 + (buf[0] & 1));
        }

A frame beginning 0xff reserves nothing.

So a frame with a bad FCS zeroes the reused skb's headroom; the next frame
begins ff 03, so nothing is reserved; process_input_packet() pulls the
two-byte address/control field, giving two bytes of headroom; and
__ppp_decompress_proto() pushes one back for a PFC-compressed protocol byte,
leaving one. The filter tag then pushes two and lands a byte below skb->head:

  skbuff: skb_under_panic: len:49 put:2 head:ffff888003c10000
          data:ffff888003c0ffff tail:0x30 end:0x640 dev:<NULL>
  kernel BUG at net/core/skbuff.c:214!
  RIP: 0010:skb_panic+0x13e/0x230
  Call Trace:
   skb_push+0xbd/0x100
   ppp_receive_nonmp_frame+0x48a/0x1d10
   ppp_input+0x4e9/0x2f80
   ppp_async_process+0x2a/0xe0
   tasklet_action_common+0x20f/0x8a0
   handle_softirqs+0x18e/0x590
  Kernel panic - not syncing: Fatal exception in interrupt

Two frames from the peer are enough. It needs CONFIG_PPP_FILTER and a link
with PPPIOCSPASS or PPPIOCSACTIVE applied, which is what pppd does for
demand-dialling and for active-filter. The panic happens in softirq context,
so it takes the machine down rather than the link.

Rather than tighten the headroom bookkeeping in one transport - ppp_synctty
and any other channel driver make no such guarantee either - make room at
the site that needs it. skb_cow_head() also subsumes the skb_unclone() it
replaces.

Found by fuzzing the PPP receive path with a mutating peer on a pty;
It is interesting (remote) DoS: Root configures PPP; peer supplies two crashing
frames.

I have a working reproducer in attachment - generated with help of GenAI.
It needs root only because /dev/ppp is 0600 by default - the frames
that trigger
the panic arrive from the tty side, i.e. from the peer, so on a
configured link this
is remotely reachable.

Tested on pristine v7.2.2.

Fixes: the PPP_FILTER_INBOUND_TAG push in ppp_receive_nonmp_frame()
Signed-off-by: Vlatko Kosturjak <vlatko.kosturjak@gmail.com>

---

diff --git a/drivers/net/ppp/ppp_generic.c b/drivers/net/ppp/ppp_generic.c
index 1111111..2222222 100644
--- a/drivers/net/ppp/ppp_generic.c
+++ b/drivers/net/ppp/ppp_generic.c
@@ -2498,7 +2498,10 @@ ppp_receive_nonmp_frame(struct ppp *ppp, struct
sk_buff *skb)

 #ifdef CONFIG_PPP_FILTER
                if (ppp->pass_filter || ppp->active_filter) {
-                       if (skb_unclone(skb, GFP_ATOMIC))
+                       /* The receive path does not guarantee 2 bytes of
+                        * headroom here, so make room rather than assume it.
+                        */
+                       if (skb_cow_head(skb, 2))
                                goto err;
                        /* Check if the packet passes the pass and
active filters.
                         * See comment for PPP_FILTER_INBOUND_TAG above.

--000000000000fc8771065a7a0e5e
Content-Type: application/octet-stream; name="repro-ppp-skb.c"
Content-Disposition: attachment; filename="repro-ppp-skb.c"
Content-Transfer-Encoding: base64
Content-ID: <f_mtjp87980>
X-Attachment-Id: f_mtjp87980

LyoKICogTWluaW1hbCByZXByb2R1Y2VyOiBza2JfdW5kZXJfcGFuaWMgaW4gcHBwX3JlY2VpdmVf
bm9ubXBfZnJhbWUoKS4KICoKICogICBza2J1ZmY6IHNrYl91bmRlcl9wYW5pYzogbGVuOk4gcHV0
OjIgaGVhZDpYIGRhdGE6WC0xIC4uLgogKiAgIGtlcm5lbCBCVUcgYXQgbmV0L2NvcmUvc2tidWZm
LmM6MjE0IQogKiAgICAgc2tiX3B1c2grMHhiZAogKiAgICAgcHBwX3JlY2VpdmVfbm9ubXBfZnJh
bWUrMHg0OGEgICAoZHJpdmVycy9uZXQvcHBwL3BwcF9nZW5lcmljLmM6MjUwNikKICogICAgIHBw
cF9pbnB1dAogKiAgICAgcHBwX2FzeW5jX3Byb2Nlc3MgICAgICAgICAgICAgICAoc29mdGlycSkK
ICoKICogVEhFIEJVRwogKiAtLS0tLS0tCiAqIFR3byB0aGluZ3MgaW4gZHJpdmVycy9uZXQvcHBw
L3BwcF9hc3luYy5jIGNvbWJpbmUuCiAqCiAqIDEuIFRoZSBmcmFtZS1lcnJvciBwYXRoIHJlc2V0
cyBhIHJldXNlZCBza2IncyBoZWFkcm9vbSB0byB6ZXJvLCB3aXRoIGEKICogICAgY29tbWVudCBj
bGFpbWluZyBpdCBpcyBlcXVpdmFsZW50IHRvIGEgZnJlc2ggYWxsb2NhdGlvbiAtLSBpdCBpcyBu
b3QsIGFzCiAqICAgIGRldl9hbGxvY19za2IoKSBsZWF2ZXMgTkVUX1NLQl9QQUQ6CiAqCiAqICAg
ICAgICBlcnI6ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIC8v
IHBwcF9hc3luYy5jOjgxMgogKiAgICAgICAgICAgICAgaWYgKHNrYikgewogKiAgICAgICAgICAg
ICAgICAgICAgICAvLyBtYWtlIHNrYiBhcHBlYXIgYXMgZnJlc2hseSBhbGxvY2F0ZWQKICogICAg
ICAgICAgICAgICAgICAgICAgc2tiX3RyaW0oc2tiLCAwKTsKICogICAgICAgICAgICAgICAgICAg
ICAgc2tiX3Jlc2VydmUoc2tiLCAtIHNrYl9oZWFkcm9vbShza2IpKTsKICogICAgICAgICAgICAg
IH0KICoKICogICAgYXAtPnJwa3Qga2VlcHMgcG9pbnRpbmcgYXQgdGhhdCBza2IsIHNvIHRoZSAq
bmV4dCogZnJhbWUgcmV1c2VzIGl0IHdpdGgKICogICAgemVybyBoZWFkcm9vbS4KICoKICogMi4g
VGhlIGhlYWRyb29tIGZvciBhIG5ldyBmcmFtZSBpcyBndWVzc2VkIGZyb20gYSBzaW5nbGUgYnl0
ZSwgYW5kIHRoZQogKiAgICBjb21tZW50IGFkbWl0cyB0aGUgZ3Vlc3MgaXMgaW5jb21wbGV0ZToK
ICoKICogICAgICAgIGlmIChza2ItPmxlbiA9PSAwKSB7ICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgLy8gcHBwX2FzeW5jLmM6ODc2CiAqICAgICAgICAgICAgICAgIC8vIFRyeSB0byBnZXQg
dGhlIHBheWxvYWQgNC1ieXRlIGFsaWduZWQuIFRoaXMgc2hvdWxkIG1hdGNoCiAqICAgICAgICAg
ICAgICAgIC8vIHRoZSBQUFBfQUxMU1RBVElPTlMvUFBQX1VJL2NvbXByZXNzZWQgdGVzdHMgaW4K
ICogICAgICAgICAgICAgICAgLy8gcHJvY2Vzc19pbnB1dF9wYWNrZXQsIGJ1dCB3ZSBkbyBub3Qg
aGF2ZSBlbm91Z2ggY2hhcnMKICogICAgICAgICAgICAgICAgLy8gaGVyZSB0byB0ZXN0IGJ1Zlsx
XSBhbmQgYnVmWzJdLgogKiAgICAgICAgICAgICAgICBpZiAoYnVmWzBdICE9IFBQUF9BTExTVEFU
SU9OUykKICogICAgICAgICAgICAgICAgICAgICAgICBza2JfcmVzZXJ2ZShza2IsIDIgKyAoYnVm
WzBdICYgMSkpOwogKiAgICAgICAgfQogKgogKiAgICBXaGVuIHRoZSBmcmFtZSBzdGFydHMgd2l0
aCAweGZmLCBub3RoaW5nIGlzIHJlc2VydmVkIGF0IGFsbC4KICoKICogU286IGEgZnJhbWUgd2l0
aCBhIGJhZCBGQ1MgemVyb2VzIHRoZSByZXVzZWQgc2tiJ3MgaGVhZHJvb20sIHRoZSBuZXh0IGZy
YW1lCiAqIHN0YXJ0cyAweGZmIDB4MDMgc28gbm8gaGVhZHJvb20gaXMgcmVzZXJ2ZWQsIHByb2Nl
c3NfaW5wdXRfcGFja2V0KCkgcHVsbHMKICogdGhlIDItYnl0ZSBhZGRyZXNzL2NvbnRyb2wgKGhl
YWRyb29tIDIpLCBfX3BwcF9kZWNvbXByZXNzX3Byb3RvKCkgcHVzaGVzIDEKICogYmFjayBmb3Ig
dGhlIFBGQy1jb21wcmVzc2VkIHByb3RvY29sIGJ5dGUgKGhlYWRyb29tIDEpLCBhbmQgdGhlbgog
KiBwcHBfcmVjZWl2ZV9ub25tcF9mcmFtZSgpIHB1c2hlcyAyIG1vcmUgZm9yIFBQUF9GSUxURVJf
SU5CT1VORF9UQUc6CiAqCiAqICAgICAgICAqKF9fYmUxNiAqKXNrYl9wdXNoKHNrYiwgMikgPSBo
dG9ucyhQUFBfRklMVEVSX0lOQk9VTkRfVEFHKTsKICoKICogICAgLS0gb25lIGJ5dGUgYmVsb3cg
c2tiLT5oZWFkLiBCVUcoKS4KICoKICogVGhhdCBsYXN0IHB1c2ggb25seSBoYXBwZW5zIHdoZW4g
YSBwYXNzIG9yIGFjdGl2ZSBmaWx0ZXIgaXMgaW5zdGFsbGVkLCBzbwogKiBDT05GSUdfUFBQX0ZJ
TFRFUiBtdXN0IGJlIG9uIGFuZCB0aGUgbGluayBtdXN0IGhhdmUgaGFkIFBQUElPQ1NQQVNTIG9y
CiAqIFBQUElPQ1NBQ1RJVkUgYXBwbGllZCAtLSB3aGljaCBpcyB3aGF0IHBwcGQgZG9lcyBmb3Ig
ZGVtYW5kLWRpYWxsaW5nIGFuZAogKiBmb3IgYGFjdGl2ZS1maWx0ZXJgLgogKgogKiBCT1VOREFS
WTogc2V0dGluZyB0aGUgZmlsdGVyIGFuZCBjcmVhdGluZyB0aGUgdW5pdCBuZWVkcyByb290ICgv
ZGV2L3BwcCBpcwogKiAwNjAwKS4gVGhlIGZyYW1lcyB0aGF0IHRyaWdnZXIgaXQgY29tZSBmcm9t
IHRoZSAqdHR5KiBzaWRlLCBpLmUuIGZyb20gdGhlCiAqIHBlZXIgb24gYSByZWFsIGxpbmsuIFNv
IHRoaXMgaXMgbm90IGxvY2FsIHByaXZpbGVnZSBlc2NhbGF0aW9uOyBpdCBpcyBhCiAqIHJlbW90
ZSBwYW5pYyBvbiBhIFBQUCBsaW5rIHRoYXQgaGFzIGZpbHRlcnMgY29uZmlndXJlZC4KICoKICog
QnVpbGQ6IGdjYyAtTzEgLXN0YXRpYyAtbyByZXByby1wcHAtc2tiIHJlcHJvLXBwcC1za2IuYwog
KiBSdW4gYXMgcm9vdCBpbiBhIGRpc3Bvc2FibGUgVk0uIFBhbmljcyB3aXRoaW4gbWlsbGlzZWNv
bmRzLgogKi8KI2RlZmluZSBfR05VX1NPVVJDRQojaW5jbHVkZSA8c3RkaW8uaD4KI2luY2x1ZGUg
PHN0ZGxpYi5oPgojaW5jbHVkZSA8c3RyaW5nLmg+CiNpbmNsdWRlIDxzdGRpbnQuaD4KI2luY2x1
ZGUgPHVuaXN0ZC5oPgojaW5jbHVkZSA8ZmNudGwuaD4KI2luY2x1ZGUgPGVycm5vLmg+CiNpbmNs
dWRlIDxzeXMvaW9jdGwuaD4KI2luY2x1ZGUgPHRlcm1pb3MuaD4KCiNkZWZpbmUgTl9QUFAgMwoK
c3RydWN0IHNvY2tfZmlsdGVyXyB7IHVpbnQxNl90IGNvZGU7IHVpbnQ4X3QganQsIGpmOyB1aW50
MzJfdCBrOyB9OwpzdHJ1Y3Qgc29ja19mcHJvZ18gIHsgdW5zaWduZWQgc2hvcnQgbGVuOyBzdHJ1
Y3Qgc29ja19maWx0ZXJfICpmaWx0ZXI7IH07CgojZGVmaW5lIFBQUElPQ1NGTEFHUwlfSU9XKCd0
JywgODksIGludCkKI2RlZmluZSBQUFBJT0NTUEFTUwlfSU9XKCd0JywgNzEsIHN0cnVjdCBzb2Nr
X2Zwcm9nXykKI2RlZmluZSBQUFBJT0NORVdVTklUCV9JT1dSKCd0JywgNjIsIGludCkKI2RlZmlu
ZSBQUFBJT0NDT05ORUNUCV9JT1coJ3QnLCA1OCwgaW50KQojZGVmaW5lIFBQUElPQ0FUVENIQU4J
X0lPVygndCcsIDU2LCBpbnQpCiNkZWZpbmUgUFBQSU9DR0NIQU4JX0lPUigndCcsIDU1LCBpbnQp
CgojZGVmaW5lIFNDX0NDUF9PUEVOCTB4MDAwMDAwNDAKI2RlZmluZSBTQ19FTkFCTEVfSVAJMHgw
MDAwMDEwMAoKc3RhdGljIHVpbnQxNl90IGZjczE2KHVpbnQxNl90IGZjcywgY29uc3QgdWludDhf
dCAqcCwgaW50IG4pCnsKCWludCBpOwoKCXdoaWxlIChuLS0gPiAwKSB7CgkJZmNzIF49ICpwKys7
CgkJZm9yIChpID0gMDsgaSA8IDg7IGkrKykKCQkJZmNzID0gKHVpbnQxNl90KSgoZmNzID4+IDEp
IF4gKChmY3MgJiAxKSA/IDB4ODQwOCA6IDApKTsKCX0KCXJldHVybiBmY3M7Cn0KCi8qIFdyYXAg
YGJvZHlgIChhbHJlYWR5IGluY2x1ZGluZyBhZGRyZXNzL2NvbnRyb2wvcHJvdG9jb2wpIGFzIGFu
IEFIRExDIGZyYW1lLiAqLwpzdGF0aWMgaW50IGZyYW1lKHVpbnQ4X3QgKm91dCwgaW50IG91dHN6
LCBjb25zdCB1aW50OF90ICpib2R5LCBpbnQgYmwsCgkJIGludCBnb29kX2ZjcykKewoJdWludDhf
dCBidWZbNDA5Nl07Cgl1aW50MTZfdCBmY3M7CglpbnQgbiA9IDAsIGk7CgoJaWYgKGJsICsgMiA+
IChpbnQpc2l6ZW9mKGJ1ZikpCgkJcmV0dXJuIC0xOwoJbWVtY3B5KGJ1ZiwgYm9keSwgYmwpOwoJ
ZmNzID0gKHVpbnQxNl90KX5mY3MxNigweGZmZmYsIGJ1ZiwgYmwpOwoJaWYgKCFnb29kX2ZjcykK
CQlmY3MgXj0gMHhiZWVmOwkJCS8qIGRlbGliZXJhdGVseSB3cm9uZyAqLwoJYnVmW2JsKytdID0g
KHVpbnQ4X3QpZmNzOwoJYnVmW2JsKytdID0gKHVpbnQ4X3QpKGZjcyA+PiA4KTsKCglvdXRbbisr
XSA9IDB4N2U7Cglmb3IgKGkgPSAwOyBpIDwgYmwgJiYgbiA8IG91dHN6IC0gMjsgaSsrKSB7CgkJ
dWludDhfdCBjID0gYnVmW2ldOwoKCQlpZiAoYyA9PSAweDdlIHx8IGMgPT0gMHg3ZCB8fCBjIDwg
MHgyMCkgewoJCQlvdXRbbisrXSA9IDB4N2Q7CgkJCW91dFtuKytdID0gYyBeIDB4MjA7CgkJfSBl
bHNlIHsKCQkJb3V0W24rK10gPSBjOwoJCX0KCX0KCW91dFtuKytdID0gMHg3ZTsKCXJldHVybiBu
Owp9CgppbnQgbWFpbih2b2lkKQp7CglzdHJ1Y3Qgc29ja19maWx0ZXJfIHByb2dbMV0gPSB7IHsg
MHgwNiwgMCwgMCwgMHhmZmZmIH0gfTsgICAvKiBCUEY6IHJldCAweGZmZmYgKi8KCXN0cnVjdCBz
b2NrX2Zwcm9nXyBmcCA9IHsgMSwgcHJvZyB9OwoJdWludDhfdCBib2R5WzUxMl0sIG91dFsxMjAw
XTsKCWNoYXIgcGF0aFs2NF07Cgl1bnNpZ25lZCBpbnQgbG9jayA9IDA7CglpbnQgbWFzdGVyLCBz
bGF2ZSwgcHRuLCB1bml0X2ZkLCBjaGFuX2ZkOwoJaW50IGxkaXNjID0gTl9QUFAsIGNoYW4sIHVu
aXQgPSAtMSwgZmxhZ3MsIG4sIGk7CgoJbWFzdGVyID0gb3BlbigiL2Rldi9wdG14IiwgT19SRFdS
IHwgT19OT0NUVFkgfCBPX05PTkJMT0NLKTsKCWlmIChtYXN0ZXIgPCAwKSB7IHBlcnJvcigicHRt
eCIpOyByZXR1cm4gMTsgfQoJaWYgKGlvY3RsKG1hc3RlciwgVElPQ1NQVExDSywgJmxvY2spIDwg
MCkgeyBwZXJyb3IoInVubG9ja3B0Iik7IHJldHVybiAxOyB9CglpZiAoaW9jdGwobWFzdGVyLCBU
SU9DR1BUTiwgJnB0bikgPCAwKSB7IHBlcnJvcigicHRuIik7IHJldHVybiAxOyB9CglzbnByaW50
ZihwYXRoLCBzaXplb2YocGF0aCksICIvZGV2L3B0cy8lZCIsIHB0bik7CglzbGF2ZSA9IG9wZW4o
cGF0aCwgT19SRFdSIHwgT19OT0NUVFkgfCBPX05PTkJMT0NLKTsKCWlmIChzbGF2ZSA8IDApIHsg
cGVycm9yKCJwdHMiKTsgcmV0dXJuIDE7IH0KCgkvKiBOX1BQUCBvbiB0aGUgc2xhdmUgY3JlYXRl
cyBhIFBQUCBjaGFubmVsLiAqLwoJaWYgKGlvY3RsKHNsYXZlLCBUSU9DU0VURCwgJmxkaXNjKSA8
IDApIHsgcGVycm9yKCJUSU9DU0VURCIpOyByZXR1cm4gMTsgfQoJaWYgKGlvY3RsKHNsYXZlLCBQ
UFBJT0NHQ0hBTiwgJmNoYW4pIDwgMCkgeyBwZXJyb3IoIkdDSEFOIik7IHJldHVybiAxOyB9CgoJ
dW5pdF9mZCA9IG9wZW4oIi9kZXYvcHBwIiwgT19SRFdSKTsKCWlmICh1bml0X2ZkIDwgMCkgeyBw
ZXJyb3IoIi9kZXYvcHBwIChuZWVkcyByb290KSIpOyByZXR1cm4gMTsgfQoJaWYgKGlvY3RsKHVu
aXRfZmQsIFBQUElPQ05FV1VOSVQsICZ1bml0KSA8IDApIHsgcGVycm9yKCJORVdVTklUIik7IHJl
dHVybiAxOyB9CgoJY2hhbl9mZCA9IG9wZW4oIi9kZXYvcHBwIiwgT19SRFdSKTsKCWlmIChjaGFu
X2ZkIDwgMCkgeyBwZXJyb3IoIi9kZXYvcHBwIDIiKTsgcmV0dXJuIDE7IH0KCWlmIChpb2N0bChj
aGFuX2ZkLCBQUFBJT0NBVFRDSEFOLCAmY2hhbikgPCAwKSB7IHBlcnJvcigiQVRUQ0hBTiIpOyBy
ZXR1cm4gMTsgfQoJaWYgKGlvY3RsKGNoYW5fZmQsIFBQUElPQ0NPTk5FQ1QsICZ1bml0KSA8IDAp
IHsgcGVycm9yKCJDT05ORUNUIik7IHJldHVybiAxOyB9CgoJZmxhZ3MgPSBTQ19DQ1BfT1BFTiB8
IFNDX0VOQUJMRV9JUDsKCWlvY3RsKHVuaXRfZmQsIFBQUElPQ1NGTEFHUywgJmZsYWdzKTsKCgkv
KiBUaGUgZmlsdGVyIGlzIHdoYXQgbWFrZXMgcHBwX3JlY2VpdmVfbm9ubXBfZnJhbWUoKSBwdXNo
IDIgYnl0ZXMuICovCglpZiAoaW9jdGwodW5pdF9mZCwgUFBQSU9DU1BBU1MsICZmcCkgPCAwKSB7
IHBlcnJvcigiUFBQSU9DU1BBU1MiKTsgcmV0dXJuIDE7IH0KCglwcmludGYoIlJFUFJPOiB1bml0
PSVkIGNoYW49JWQsIHBhc3MgZmlsdGVyIGluc3RhbGxlZFxuIiwgdW5pdCwgY2hhbik7CglmZmx1
c2goc3Rkb3V0KTsKCgkvKgoJICogRnJhbWUgMTogYmFkIEZDUy4gcHJvY2Vzc19pbnB1dF9wYWNr
ZXQoKSB0YWtlcyBpdHMgZXJyOiBwYXRoLCB3aGljaAoJICogdHJpbXMgdGhlIHNrYiBhbmQgc2V0
cyBpdHMgaGVhZHJvb20gdG8gemVybyAtLSBhbmQgbGVhdmVzIGl0IGluCgkgKiBhcC0+cnBrdCB0
byBiZSByZXVzZWQuCgkgKi8KCWJvZHlbMF0gPSAweGZmOwoJYm9keVsxXSA9IDB4MDM7Cglib2R5
WzJdID0gMHgwMDsKCWJvZHlbM10gPSAweDIxOwkJCS8qIFBQUF9JUCwgdW5jb21wcmVzc2VkICov
Cglmb3IgKGkgPSA0OyBpIDwgMzI7IGkrKykKCQlib2R5W2ldID0gKHVpbnQ4X3QpaTsKCW4gPSBm
cmFtZShvdXQsIHNpemVvZihvdXQpLCBib2R5LCAzMiwgMCAvKiBiYWQgRkNTICovKTsKCWlmICh3
cml0ZShtYXN0ZXIsIG91dCwgbikgIT0gbikgeyBwZXJyb3IoIndyaXRlIDEiKTsgcmV0dXJuIDE7
IH0KCXByaW50ZigiUkVQUk86IHNlbnQgZnJhbWUgMSAoYmFkIEZDUykgLS0gaGVhZHJvb20gb2Yg
dGhlIHJldXNlZCBza2IgaXMgbm93IDBcbiIpOwoJZmZsdXNoKHN0ZG91dCk7Cgl1c2xlZXAoNTAw
MDApOwoKCS8qCgkgKiBGcmFtZSAyLCBvbiB0aGUgc2tiIGZyYW1lIDEgbGVmdCBiZWhpbmQ6Cgkg
KiAgIHN0YXJ0cyAweGZmICAtPiBwcHBfYXN5bmNfaW5wdXQoKSByZXNlcnZlcyBub3RoaW5nCgkg
KiAgIDB4ZmYgMHgwMyAgICAtPiBwcm9jZXNzX2lucHV0X3BhY2tldCgpIHB1bGxzIDIgICAoaGVh
ZHJvb20gMikKCSAqICAgMHgyMSAgICAgICAgIC0+IFBGQy1jb21wcmVzc2VkIFBQUF9JUCwgb2Rk
LCBzbwoJICogICAgICAgICAgICAgICAgICAgX19wcHBfZGVjb21wcmVzc19wcm90bygpIHB1c2hl
cyAxIChoZWFkcm9vbSAxKQoJICogICBQUFBfSVAgbWFwcyB0byBhIHJlYWwgTlAgaW5kZXgsIHNv
IHRoZSBmaWx0ZXIgYnJhbmNoIHJ1bnMgYW5kCgkgKiAgIHB1c2hlcyAyIC0+IG9uZSBieXRlIGJl
bG93IHNrYi0+aGVhZCAtPiBCVUcoKS4KCSAqLwoJYm9keVswXSA9IDB4ZmY7Cglib2R5WzFdID0g
MHgwMzsKCWJvZHlbMl0gPSAweDIxOwkJCS8qIGNvbXByZXNzZWQgcHJvdG9jb2wgZmllbGQsIG9k
ZCAqLwoJYm9keVszXSA9IDB4NDU7CQkJLyogbG9va3MgbGlrZSBhbiBJUHY0IGhlYWRlciAqLwoJ
Ym9keVs0XSA9IDB4MDA7Cglib2R5WzVdID0gMHgwMDsKCWJvZHlbNl0gPSAweDI4OwoJZm9yIChp
ID0gNzsgaSA8IDQ4OyBpKyspCgkJYm9keVtpXSA9ICh1aW50OF90KShpICogNyk7CgluID0gZnJh
bWUob3V0LCBzaXplb2Yob3V0KSwgYm9keSwgNDgsIDEgLyogZ29vZCBGQ1MgKi8pOwoJcHJpbnRm
KCJSRVBSTzogc2VuZGluZyBmcmFtZSAyIChmZiAwMyArIFBGQyBQUFBfSVApIC0tIGV4cGVjdCBz
a2JfdW5kZXJfcGFuaWNcbiIpOwoJZmZsdXNoKHN0ZG91dCk7CglpZiAod3JpdGUobWFzdGVyLCBv
dXQsIG4pICE9IG4pIHsgcGVycm9yKCJ3cml0ZSAyIik7IHJldHVybiAxOyB9CgoJdXNsZWVwKDIw
MDAwMCk7CglwcmludGYoIlJFUFJPOiBzdGlsbCBhbGl2ZSAtLSBkaWQgTk9UIHJlcHJvZHVjZVxu
Iik7CglmZmx1c2goc3Rkb3V0KTsKCXJldHVybiAwOwp9Cg==
--000000000000fc8771065a7a0e5e--
