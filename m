Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 473081A6805
	for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 12:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785154596; cv=pass; b=aJElnMY2QKn2I2ogL9TS2DKN9Opjtc6d700jC5xNx55eZ9F0kaKNLBmt7VrDvGJzoSoP/g0P1K+MCKU/MpAj1OtMXOANNlZjrf+ZpeP8nsezx7mDHhntOOHeVaQhwpgeP5Az89S6vsgFOW1JPtSDIEwxizOFbXG0PO5zP8axw8w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785154596; c=relaxed/simple;
	bh=QkMi+St4m2k6zQcPzBXo+AHgop7HNa9e8eqN3vlqxjY=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=XPH+GpS2rsevtU8apSUczMGVJxXt4fulosxlT2UFwAo3PWJYc3OHzKEGQq9z9ftpA7igFuH/sCIre0OwAXc5Ps/LfB+AswqY61rR8pyNA5hNMyhFs4NTkOmyoq3GQQV3J53vxtqC1dLH5dkF6fNwtC5EJxv6nBCOIzS89nvU2CU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HbgW5bz9; arc=pass smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HbgW5bz9"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-51c8e2e39easo26275521cf.0
        for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 05:16:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785154594; cv=none;
        d=google.com; s=arc-20260327;
        b=cXcigtgUUDVh3NFVBRPJDqxm97NYjJSoD4IAHvCzBHDTuy8JvnbY6rkr+q1sG8keXC
         NINXMLDeq/ovZQxsXLwopzeWOxDqacRRIAzU6vKSAsiJf/28LgB2o+1i0OEo7q7iXKp1
         bmL/wFv9AWx4SJYTnkMFas6s9zvYwI8OFjhplQfiVR3l+eHJT7byAaEZs2z8gjbV3dUL
         EbMRXJuwPOv/vXwAmqjV25hDutyJRiVsanmmGCt9ukwSIK0uvWFAyoLX5nLkpdr8HF5d
         tqJiEN0C2OHcN0OcVm/7P6esQA6XjvmMqQ0mmqdY80vErsz8DtrYMdAYoP5uLugzvQyY
         jKDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=ykhfy8o7sKL8ctTrdjI5DAuaXeV5GPTy4ly/8f5734I=;
        fh=ssWMcbP40I3EizeuhTKePfDKNW+A4cM5GgwGfXuvi9Y=;
        b=qaFs2xPzHbYSR0m+X5u02UUEZtqjiNVpBWiT57WoMJA6FGe6Tdn5UwG6AkZ4b/0bW/
         xiBJq6RZNNuh9o6RY/CK3ZyZi0p60vIly7o2tLGGjAbSFHM4LZ+DYabCsEKeKZUS2X55
         r8mc4N4nfN18gi7srKbPZhkQ0kAsUe3lbQLfot03/o70aORSitxcvthyu0fgGvwpglhr
         oL8MTlrN2xytwWJQ8eHuZI6Q/eg9u89DKoz/ptmoh92aAXv1RNqly/lyabFImyFW/yqW
         axwosK2w1RtGdenEC2hsRtfVsjWMNwKLADyk5gGNH9S4jRiTLbugyNRJGFBXxODBgbVh
         nD6Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785154594; x=1785759394; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ykhfy8o7sKL8ctTrdjI5DAuaXeV5GPTy4ly/8f5734I=;
        b=HbgW5bz9I+eQwcom47Ubp01wEmUur4Jn6jj3kXt1HB5BcfKwjx1tHtuxSDJ0HDH/lF
         EtEjqu5fvfEauugscDghcYFPvJ5N88Lij0qkV53d9GgLzCv7hP4qWn5k4FoZzdvVKIbG
         GZ+6sGGEwStJYmhgqKoCTod6vEf9V82Sg3Tr189P82e7O8n6GY2yDYI61Ro3knFPVrZv
         pV8Ph8F3tP2ivM6eHYO06U4731XJYPZCslWC3l9x0kK4c9SeHKHZffSxYnUzKtHJlqpt
         zIwAp3SFtwr2JpH+hbsCOMa4WB9qwKlrkyOxpdsuj+EqkfpsNfsM8iKimq4MAGEeoqUQ
         4aqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785154594; x=1785759394;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ykhfy8o7sKL8ctTrdjI5DAuaXeV5GPTy4ly/8f5734I=;
        b=cN6lCHODd8Q1qC/kJGX3kpuMbL4nh4J7Y1Ep29AhhwL8Raj6bXjDX95eFvuq8LG7Oq
         GCYVik3VzLIztw+cT0Oz9vdRB9+XUdTgwQKsF78hsgGxyPx2blfXiOv8el0CxnnicqBJ
         eDUiBcKCYX1tz5j32tLQXa2TNTgqh2YF+JX0Vakr76KcKqw4iZ+LiV24khqVC3JeP0/n
         QrkTi4ztFqn6LMaizQgr4TtWnt0RnO0dUowHsFKav39nbAPsbeiyfdm3Ojxp3F4yod9Q
         VHER4o90qCsP02fLP9TYtb0pV4fCwaqc/OSELsJ+NZ3Lf29GuVqXiiTQSJnKCJcX6MPL
         em5w==
X-Gm-Message-State: AOJu0Yz08bcMItDksLZiTl1dxLChyvY1Qt6Eo5ZvNzTBsozFvnP3nTmE
	i7xofrZXlCzhVauGgtXvHwnJEU0i2OjAsCESYt89X8hcuv4Br6b/QiGrzRIXlZYXkJWVUd3EGUI
	SAa7AQgU32+Q/KCDmK/E8zBoSG1gJhF7qs4K/
X-Gm-Gg: AR+sD124KNsFwbMceLj1YIX8rlFkGDokLMrwtWlXvGfaJPdhLkFJuGaUM8UuRYH2HrW
	N6+XB4aD6ZtjJ8t5SHlpxM5f85ieUklU1kVVuRUe6I6ptwOuKYikwxU+WzgHJFY3E7d78C6S6Wu
	XzbXxla3g8bvbuclQdoF0XusCdUCOkHx/eNvjI2xWZeiFJkRQukZAHW1iScm4dDoHhBccLK3PWj
	BIZ1Iy9UMl+4eCdddkeCptW6IjVarx91Tbd916gB5yjpZVhv1gI3Z0LhIbAKAMlvKNtKDB3nqCZ
	3faP4sr8F1Ti4jqeIA==
X-Received: by 2002:a05:622a:164a:b0:51c:7b11:419c with SMTP id
 d75a77b69052e-529a88854bfmr81430291cf.73.1785154594064; Mon, 27 Jul 2026
 05:16:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Ashish Kunwar <ashishkunwar280@gmail.com>
Date: Mon, 27 Jul 2026 17:46:21 +0530
X-Gm-Features: AUfX_mxSf9kFb7hHhAB2Wqcz_dZeoeU7GEVt5EoRHM4OUoh6Bgj3DOCFXE3vZ7o
Message-ID: <CACk7sWd8q8Go4BEBNiVstgJpK6FvC4myj6yNEHdOMEE9QaB3Vg@mail.gmail.com>
Subject: [PATCH v2] xfrm: fix TOCTOU race in per-CPU state cache add path
To: netdev@vger.kernel.org
Cc: steffen.klassert@secunet.com, davem@davemloft.net, kuba@kernel.org
Content-Type: multipart/mixed; boundary="00000000000072e440065796b16e"

--00000000000072e440065796b16e
Content-Type: multipart/alternative; boundary="00000000000072e43e065796b16c"

--00000000000072e43e065796b16c
Content-Type: text/plain; charset="UTF-8"

xfrm_input_state_lookup() checks x->km.state == XFRM_STATE_VALID
without holding xfrm_state_lock, then acquires the lock and adds the
state to the per-CPU state_cache_input list. A concurrent
__xfrm_state_delete() on another CPU can set km.state to DEAD and
remove the state from the cache between the check and the lock
acquisition. The lookup then re-adds the now-DEAD state to the cache.

After GC frees the xfrm_state, the per-CPU cache holds a dangling
pointer. The next inbound packet that iterates the cache dereferences
freed slab memory.

The same pattern exists in xfrm_state_find() for the outbound
state_cache.

Fix both by re-checking km.state inside the lock before adding the
state to the cache. For xfrm_input_state_lookup, a DEAD state must
not be returned to the caller, so drop the refcount and return NULL.
For xfrm_state_find, fold the state check into the existing
conditional so the cache insertion is simply skipped.

Fixes: 81a331a0e72 ("xfrm: add an inbound state cache")
Signed-off-by: Ashish Kunwar <ashishkunwar280@gmail.com>
---
v2: Rebased, fixed outbound path to use proper conditional instead of
empty statement. Submitted to netdev per Steffen's feedback.
---
net/xfrm/xfrm_state.c | 9 ++++++++-
1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index 1748d37..d8a9cd1 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -1230,6 +1230,12 @@ struct xfrm_state *xfrm_input_state_lookup(struct
net *net, u32 mark,

if (x && x->km.state == XFRM_STATE_VALID) {
spin_lock_bh(&net->xfrm.xfrm_state_lock);
+ if (x->km.state != XFRM_STATE_VALID) {
+ spin_unlock_bh(&net->xfrm.xfrm_state_lock);
+ xfrm_state_put(x);
+ x = NULL;
+ goto out;
+ }
if (hlist_unhashed(&x->state_cache_input)) {
hlist_add_head_rcu(&x->state_cache_input, state_cache_input);
} else {
@@ -1622,7 +1628,8 @@ out:
if (x && x->km.state == XFRM_STATE_VALID && !cached &&
(!(pol->flags & XFRM_POLICY_CPU_ACQUIRE) || x->pcpu_num == pcpu_id)) {
spin_lock_bh(&net->xfrm.xfrm_state_lock);
- if (hlist_unhashed(&x->state_cache))
+ if (x->km.state == XFRM_STATE_VALID &&
+ hlist_unhashed(&x->state_cache))
hlist_add_head_rcu(&x->state_cache, &pol->state_cache_list);
spin_unlock_bh(&net->xfrm.xfrm_state_lock);
}
-- 
2.50.1

--00000000000072e43e065796b16c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div dir=3D"auto">xfrm_input_state_lookup() checks x-=
&gt;km.state =3D=3D XFRM_STATE_VALID<br>without holding xfrm_state_lock, th=
en acquires the lock and adds the<br>state to the per-CPU state_cache_input=
 list. A concurrent<br>__xfrm_state_delete() on another CPU can set km.stat=
e to DEAD and<br>remove the state from the cache between the check and the =
lock<br>acquisition. The lookup then re-adds the now-DEAD state to the cach=
e.<br><br>After GC frees the xfrm_state, the per-CPU cache holds a dangling=
<br>pointer. The next inbound packet that iterates the cache dereferences<b=
r>freed slab memory.<br><br>The same pattern exists in xfrm_state_find() fo=
r the outbound<br>state_cache.<br><br>Fix both by re-checking km.state insi=
de the lock before adding the<br>state to the cache. For xfrm_input_state_l=
ookup, a DEAD state must<br>not be returned to the caller, so drop the refc=
ount and return NULL.<br>For xfrm_state_find, fold the state check into the=
 existing<br>conditional so the cache insertion is simply skipped.<br><br>F=
ixes: 81a331a0e72 (&quot;xfrm: add an inbound state cache&quot;)<br>Signed-=
off-by: Ashish Kunwar &lt;<a href=3D"mailto:ashishkunwar280@gmail.com" targ=
et=3D"_blank">ashishkunwar280@gmail.com</a>&gt;<br>---<br>v2: Rebased, fixe=
d outbound path to use proper conditional instead of<br>    empty statement=
. Submitted to netdev per Steffen&#39;s feedback.<br>---<br> net/xfrm/xfrm_=
state.c | 9 ++++++++-<br> 1 file changed, 8 insertions(+), 1 deletion(-)<br=
><br>diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c<br>index 17=
48d37..d8a9cd1 100644<br>--- a/net/xfrm/xfrm_state.c<br>+++ b/net/xfrm/xfrm=
_state.c<br>@@ -1230,6 +1230,12 @@ struct xfrm_state *xfrm_input_state_look=
up(struct net *net, u32 mark,<br> <br> 	if (x &amp;&amp; x-&gt;km.state =3D=
=3D XFRM_STATE_VALID) {<br> 		spin_lock_bh(&amp;net-&gt;xfrm.xfrm_state_loc=
k);<br>+		if (x-&gt;km.state !=3D XFRM_STATE_VALID) {<br>+			spin_unlock_bh=
(&amp;net-&gt;xfrm.xfrm_state_lock);<br>+			xfrm_state_put(x);<br>+			x =3D=
 NULL;<br>+			goto out;<br>+		}<br> 		if (hlist_unhashed(&amp;x-&gt;state_c=
ache_input)) {<br> 			hlist_add_head_rcu(&amp;x-&gt;state_cache_input, stat=
e_cache_input);<br> 		} else {<br>@@ -1622,7 +1628,8 @@ out:<br> 	if (x &am=
p;&amp; x-&gt;km.state =3D=3D XFRM_STATE_VALID &amp;&amp; !cached &amp;&amp=
;<br> 	    (!(pol-&gt;flags &amp; XFRM_POLICY_CPU_ACQUIRE) || x-&gt;pcpu_nu=
m =3D=3D pcpu_id)) {<br> 		spin_lock_bh(&amp;net-&gt;xfrm.xfrm_state_lock);=
<br>-		if (hlist_unhashed(&amp;x-&gt;state_cache))<br>+		if (x-&gt;km.state=
 =3D=3D XFRM_STATE_VALID &amp;&amp;<br>+		    hlist_unhashed(&amp;x-&gt;sta=
te_cache))<br> 			hlist_add_head_rcu(&amp;x-&gt;state_cache, &amp;pol-&gt;s=
tate_cache_list);<br> 		spin_unlock_bh(&amp;net-&gt;xfrm.xfrm_state_lock);<=
br> 	}<br>-- <br>2.50.1</div></div></div>

--00000000000072e43e065796b16c--
--00000000000072e440065796b16e
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="v2-0001-xfrm-fix-TOCTOU-race-in-state-cache-add-path.patch"
Content-Disposition: attachment; 
	filename="v2-0001-xfrm-fix-TOCTOU-race-in-state-cache-add-path.patch"
Content-Transfer-Encoding: base64
Content-ID: <>
X-Attachment-Id: 

RnJvbSAxZjM5OTA5MzM1NWE2NDNmMWYyN2JlYmVhOTc1MzliMDk4ODY1OTJkIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBc2hpc2ggS3Vud2FyIDxhc2hpc2hrdW53YXIyODBAZ21haWwu
Y29tPgpEYXRlOiBNb24sIDI3IEp1bCAyMDI2IDE3OjM0OjIyICswNTMwClN1YmplY3Q6IFtQQVRD
SF0geGZybTogZml4IFRPQ1RPVSByYWNlIGluIHBlci1DUFUgc3RhdGUgY2FjaGUgYWRkIHBhdGgK
Cnhmcm1faW5wdXRfc3RhdGVfbG9va3VwKCkgY2hlY2tzIHgtPmttLnN0YXRlID09IFhGUk1fU1RB
VEVfVkFMSUQKd2l0aG91dCBob2xkaW5nIHhmcm1fc3RhdGVfbG9jaywgdGhlbiBhY3F1aXJlcyB0
aGUgbG9jayBhbmQgYWRkcyB0aGUKc3RhdGUgdG8gdGhlIHBlci1DUFUgc3RhdGVfY2FjaGVfaW5w
dXQgbGlzdC4gQSBjb25jdXJyZW50Cl9feGZybV9zdGF0ZV9kZWxldGUoKSBvbiBhbm90aGVyIENQ
VSBjYW4gc2V0IGttLnN0YXRlIHRvIERFQUQgYW5kCnJlbW92ZSB0aGUgc3RhdGUgZnJvbSB0aGUg
Y2FjaGUgYmV0d2VlbiB0aGUgY2hlY2sgYW5kIHRoZSBsb2NrCmFjcXVpc2l0aW9uLiBUaGUgbG9v
a3VwIHRoZW4gcmUtYWRkcyB0aGUgbm93LURFQUQgc3RhdGUgdG8gdGhlIGNhY2hlLgoKQWZ0ZXIg
R0MgZnJlZXMgdGhlIHhmcm1fc3RhdGUsIHRoZSBwZXItQ1BVIGNhY2hlIGhvbGRzIGEgZGFuZ2xp
bmcKcG9pbnRlci4gVGhlIG5leHQgaW5ib3VuZCBwYWNrZXQgdGhhdCBpdGVyYXRlcyB0aGUgY2Fj
aGUgZGVyZWZlcmVuY2VzCmZyZWVkIHNsYWIgbWVtb3J5LgoKVGhlIHNhbWUgcGF0dGVybiBleGlz
dHMgaW4geGZybV9zdGF0ZV9maW5kKCkgZm9yIHRoZSBvdXRib3VuZApzdGF0ZV9jYWNoZS4KCkZp
eCBib3RoIGJ5IHJlLWNoZWNraW5nIGttLnN0YXRlIGluc2lkZSB0aGUgbG9jayBiZWZvcmUgYWRk
aW5nIHRoZQpzdGF0ZSB0byB0aGUgY2FjaGUuIEZvciB4ZnJtX2lucHV0X3N0YXRlX2xvb2t1cCwg
YSBERUFEIHN0YXRlIG11c3QKbm90IGJlIHJldHVybmVkIHRvIHRoZSBjYWxsZXIsIHNvIGRyb3Ag
dGhlIHJlZmNvdW50IGFuZCByZXR1cm4gTlVMTC4KRm9yIHhmcm1fc3RhdGVfZmluZCwgZm9sZCB0
aGUgc3RhdGUgY2hlY2sgaW50byB0aGUgZXhpc3RpbmcKY29uZGl0aW9uYWwgc28gdGhlIGNhY2hl
IGluc2VydGlvbiBpcyBzaW1wbHkgc2tpcHBlZC4KCkZpeGVzOiA4MWEzMzFhMGU3MiAoInhmcm06
IGFkZCBhbiBpbmJvdW5kIHN0YXRlIGNhY2hlIikKU2lnbmVkLW9mZi1ieTogQXNoaXNoIEt1bndh
ciA8YXNoaXNoa3Vud2FyMjgwQGdtYWlsLmNvbT4KLS0tCiBuZXQveGZybS94ZnJtX3N0YXRlLmMg
fCA5ICsrKysrKysrLQogMSBmaWxlIGNoYW5nZWQsIDggaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlv
bigtKQoKZGlmZiAtLWdpdCBhL25ldC94ZnJtL3hmcm1fc3RhdGUuYyBiL25ldC94ZnJtL3hmcm1f
c3RhdGUuYwppbmRleCAxNzQ4ZDM3Li5kOGE5Y2QxIDEwMDY0NAotLS0gYS9uZXQveGZybS94ZnJt
X3N0YXRlLmMKKysrIGIvbmV0L3hmcm0veGZybV9zdGF0ZS5jCkBAIC0xMjMwLDYgKzEyMzAsMTIg
QEAgc3RydWN0IHhmcm1fc3RhdGUgKnhmcm1faW5wdXRfc3RhdGVfbG9va3VwKHN0cnVjdCBuZXQg
Km5ldCwgdTMyIG1hcmssCiAKIAlpZiAoeCAmJiB4LT5rbS5zdGF0ZSA9PSBYRlJNX1NUQVRFX1ZB
TElEKSB7CiAJCXNwaW5fbG9ja19iaCgmbmV0LT54ZnJtLnhmcm1fc3RhdGVfbG9jayk7CisJCWlm
ICh4LT5rbS5zdGF0ZSAhPSBYRlJNX1NUQVRFX1ZBTElEKSB7CisJCQlzcGluX3VubG9ja19iaCgm
bmV0LT54ZnJtLnhmcm1fc3RhdGVfbG9jayk7CisJCQl4ZnJtX3N0YXRlX3B1dCh4KTsKKwkJCXgg
PSBOVUxMOworCQkJZ290byBvdXQ7CisJCX0KIAkJaWYgKGhsaXN0X3VuaGFzaGVkKCZ4LT5zdGF0
ZV9jYWNoZV9pbnB1dCkpIHsKIAkJCWhsaXN0X2FkZF9oZWFkX3JjdSgmeC0+c3RhdGVfY2FjaGVf
aW5wdXQsIHN0YXRlX2NhY2hlX2lucHV0KTsKIAkJfSBlbHNlIHsKQEAgLTE2MjIsNyArMTYyOCw4
IEBAIG91dDoKIAlpZiAoeCAmJiB4LT5rbS5zdGF0ZSA9PSBYRlJNX1NUQVRFX1ZBTElEICYmICFj
YWNoZWQgJiYKIAkgICAgKCEocG9sLT5mbGFncyAmIFhGUk1fUE9MSUNZX0NQVV9BQ1FVSVJFKSB8
fCB4LT5wY3B1X251bSA9PSBwY3B1X2lkKSkgewogCQlzcGluX2xvY2tfYmgoJm5ldC0+eGZybS54
ZnJtX3N0YXRlX2xvY2spOwotCQlpZiAoaGxpc3RfdW5oYXNoZWQoJngtPnN0YXRlX2NhY2hlKSkK
KwkJaWYgKHgtPmttLnN0YXRlID09IFhGUk1fU1RBVEVfVkFMSUQgJiYKKwkJICAgIGhsaXN0X3Vu
aGFzaGVkKCZ4LT5zdGF0ZV9jYWNoZSkpCiAJCQlobGlzdF9hZGRfaGVhZF9yY3UoJngtPnN0YXRl
X2NhY2hlLCAmcG9sLT5zdGF0ZV9jYWNoZV9saXN0KTsKIAkJc3Bpbl91bmxvY2tfYmgoJm5ldC0+
eGZybS54ZnJtX3N0YXRlX2xvY2spOwogCX0KLS0gCjIuNTAuMSAoQXBwbGUgR2l0LTE1NSkKCg==
--00000000000072e440065796b16e--
