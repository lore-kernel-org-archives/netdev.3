Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF2BD3C73CC
	for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 04:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790137402; cv=pass; b=fDAt1sP0vuKdFaIRKt7X9WUG5up3+g7uywr620Z7e63fLoIuGozmvnKtDdZuuUg+o9GP15aAbDHvCSJ+3DmE2oPZSl7fx4uOOqnv1mdbr4iToD9yQ9TRZz+3roLF875MPYeEQyjVn7wQRVNTpRljvMCewM3Xcr9BKhcI7GtTK9w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790137402; c=relaxed/simple;
	bh=gSzS4KWkazS0J10QoPHcTqoIQSbG0vezG/+WEMtKl6E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SXRf121jaQouyCy/IBdn2nbEm1ts5arF8KnU9RbwAjE3K4/R73ED8J9X+Pa53rGqA2wLW9rHLu1gd2eu/+FDmg0sAzd1VYLyHExPINfhPYqoJ4Oa2LaQjKliGSxuU402yL5ZTAjqQ+n4wRiZ3mkpL7DwyFkbGEeXJHfrSamRWKg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qSPfCN89; arc=pass smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qSPfCN89"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c254f705536so85389266b.1
        for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 21:23:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790137399; cv=none;
        d=google.com; s=arc-20260327;
        b=TovGD9sR8GuedX5ohZhmEkqla6EjradCC66O7EM0ajo8PzuRwWGYHAG9W+Al77NXol
         stI6XZ8I45IRZnJ3GFTDhnWDXbqsql1tgc92U7/rrlR1nLcpBXRqdnL0LDGwUAOty+SY
         BW5fXwmvGg3B4PHM2TpsSot2GWTiOoFM7Fiq+a9fTqLa0GZNrr8ltVuDCFEzF8P1CWVH
         EaQQngEoTD8xr7AmtYCPUH900G0Kx/HL4kWW0l34hmPtAZrAcU5OauyERtn087Y5MHPP
         JWHCwFcWUmRRXGvbaRZEwq0PQ9ChQsZBjYcmx1UMoR5Omhd+6gTCjLRorjMf5VDcb8Ul
         HVRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=hYM/7bLUGxyRtWdyLWW9t13fc88vkJMEH+8MGAulUSs=;
        fh=DZjeT44RT7dE3k32kkelC8mV8ZaYaZNw1XXl4niQxXE=;
        b=mKVF+e5UmLQGDX9yrtjZM6kE2Iaw78AstkqTGoAxPG+Ges3XH2TJCvg78KwL4e6FDR
         0S+pgO4Fv8fKHGCnnAM47ElAuuBAGIFJOXQ2WF8bTgybBtjIPZ/Yqx1Y9kWn8H+8A1Ps
         CDwnk75SjFyxrapgy5oeMP+UFzj0SzsWlb1SJIAmWpUTF2paJiyH4BM+gkbSK6faxEk5
         3nDLJwJ8FVC6L9QyC3vUZeq5LVyoHuHTCr7ek2D5xSdJ8B1SdZPcabYWfYbZJqJr5rcO
         MK1iBybc2PxK+06IQE+kl9jalg0HRVMSB+qgnGfoYK7LuCoa3GDhmYKH/nGyfmFsQ8Mp
         irmQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790137399; x=1790742199; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hYM/7bLUGxyRtWdyLWW9t13fc88vkJMEH+8MGAulUSs=;
        b=qSPfCN89GyFw70INMcJf3lvyXJnktwAGz5oiP6UjrHXS1F/z1s+6LBp3fBaPqOAP/0
         /xSfpstiKf6zyrppYo8Z6XLjP2JEPgNMjEvdcCxh/GrdP6i1vwfrGQQD/CXPtVcWa1e7
         SrL37DkcieUyWxHBrpKOoosJddyRcfr00D9QoLTXSVeY7vT1OlHxAyK50NaGyDZULy7X
         F3fcA7zmfDQ124V9GPmkN+QA1AZlutCWfPpFZBk3sq+GlMtQrNlxi7N56CdWtTkMjUBl
         HybTMgdq6STR06E4ikUKqJGJVHduIFG3yy1P4ta9C6ky/sgLGqoCtdlD7upHg/AJc+W7
         lgmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790137399; x=1790742199;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=hYM/7bLUGxyRtWdyLWW9t13fc88vkJMEH+8MGAulUSs=;
        b=oc0BCgcZdS9uCZUs/j8PeNO8o11gfii5QHRDBx3NqUiZs/haD372Z4qHrneHeShBKZ
         YYUP7JkEcbGs8iwl1zHDKIh7wAqhHCHjV8XmNka8BnwMjWwa9fGSzWAsC5j/J0O2T49r
         zk8ZDSuf8s02BEtSRUNNHQz/viA6pe7Z6S275U+fxXj38FoJS2JytyPz0ydtNfNdVfPi
         JaWxwDdo8SN46ZuQe5E1Aa/fwSDeO5WyCuFvdo3gNy9Fbyfo1o1IsF0ONWgFbn46GEB1
         cY8RgOtqiIlIF+m8qaV33kHHI80jVNNv7NwYcP0pLwMemCRXEBHbau4BZZ9QgAmcwB2U
         ESoA==
X-Forwarded-Encrypted: i=1; AKwUvBx9OUVBfkMUyDQMmui0002D2HcFu+34OhrX8fvh3pO+Og/0wiWMIscbKPweeVwfaZzskl38pt4=@vger.kernel.org
X-Gm-Message-State: AFuF++kTGZu2FpKTQFJ/iMouVwtp9coH9d2SgRddl1qVWAosrCsmOb2e
	UNJLOtr2MwxD+LzFiiaUydTQI/DKK0zqeZLaIS4Wbswqa/9q1uT9k2XvfqGcPTstFl6xRErllA5
	6rEjs2BBgvrABATZlWMf2/uL7oYgJdPY=
X-Gm-Gg: AYBFou2a13LJVJ8AWEjSblv6/swIq+KW2JooIjJgOjuR65iBxbNBh7THcmPdQ8fkUT7
	GGCpyjxAtjnAMihsm3mnWL61Q/RrpSP5kwJ+ewtdqvJpsrIZgFhAQ3qmwMxUssazCXGulKn+gAa
	drVyCNiSIaEKfUXAH6t8yIWBGyLaWqTj6uGTu5jn83t9C7GGXqkAKRZ0RraQlzJSQaOKdbgSmpS
	hwcnCXflvPfgnILZP8RfoRinOFuorlDoiOpa+UNFn0IFOS/XdsVHU60Q+5d05YFFE3B50/TP0yC
	uBrQmc2tA7SyvX7+vfFSJC5aNfjyL1c3ysjIhgbcsfPjCBhqlzx0UL8z+IDiYAY8az0yFphNurW
	aFQ==
X-Received: by 2002:a17:907:6e92:b0:c26:1648:a06a with SMTP id
 a640c23a62f3a-c2aadf937b2mr97414066b.37.1790137398653; Tue, 22 Sep 2026
 21:23:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHeizqHDqx3ue1=0QL92ef+6C63Ur+v1Z=d93smgdD5zTj_-Pw@mail.gmail.com>
In-Reply-To: <CAHeizqHDqx3ue1=0QL92ef+6C63Ur+v1Z=d93smgdD5zTj_-Pw@mail.gmail.com>
From: Subham Pal <subhampal789@gmail.com>
Date: Wed, 23 Sep 2026 09:53:06 +0530
X-Gm-Features: AcwNN1WEEhy2iwQK4B069tS0XRk4xme6FybPrSApBHbz4SeUCjO1PRgvkEh5d0Q
Message-ID: <CAHeizqHTVysNHjShNK-aEhQqs74LiJe0P_tb-0sWoUVbQJYVvg@mail.gmail.com>
Subject: [PATCH net 1/2] netfilter: nf_conntrack_h323: do not bypass NAT
 helpers when tuple source matches reply destination
To: pablo@netfilter.org, fw@strlen.de
Cc: phil@nwl.cc, kaber@trash.net, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	netfilter-devel@vger.kernel.org, netdev@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000c160c7065c1ed789"

--000000000000c160c7065c1ed789
Content-Type: text/plain; charset="UTF-8"

The expectation helpers (expect_h245, expect_rtp_rtcp, expect_t120, and
expect_callforwarding) test whether NAT is required by comparing the
forward source IP against the reverse destination IP:

    memcmp(&ct->tuplehash[dir].tuple.src.u3,
           &ct->tuplehash[!dir].tuple.dst.u3,
           sizeof(ct->tuplehash[dir].tuple.src.u3))

This check is broken for multiple reasons:

1. It incorrectly evaluates to 0 in the reply direction
   (dir == IP_CT_DIR_REPLY) even under SNAT, because tuplehash[REPLY].src
   and tuplehash[ORIGINAL].dst both represent the remote peer's address.
2. In Destination NAT (DNAT) and hairpin setups, the sender's source IP
   is never modified, causing this check to evaluate to false even though
   NAT payload rewriting is necessary.

As a result, NAT payload mangling is bypassed, leaving internal addresses
untranslated inside the signaling packets and leading to call setup and
media stream failures.

Remove the redundant memcmp() checks across all four expectation helpers.
Verifying that nathook is present and that ct->status matches IPS_NAT_MASK
is sufficient to determine whether NAT handling should execute.

Fixes: f587de0e2feb ("[NETFILTER]: nf_conntrack/nf_nat: add H.323 helper port")
Cc: stable@vger.kernel.org
Signed-off-by: Subham Pal <subhampal789@gmail.com>
---
[Note: Raw patch attached to avoid webmail tab/whitespace corruption]

--000000000000c160c7065c1ed789
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-netfilter-nf_conntrack_h323-do-not-bypass-NAT-helper.patch"
Content-Disposition: attachment; 
	filename="0001-netfilter-nf_conntrack_h323-do-not-bypass-NAT-helper.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_mudlkd6o0>
X-Attachment-Id: f_mudlkd6o0

RnJvbSBlYjc4NzQ4Y2MzY2I2MDMyNTY2YTY0OWNlZWFkZjk5Yzc4OGY0NTczIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTdWJoYW0gUGFsIDxzdWJoYW1wYWw3ODlAZ21haWwuY29tPgpE
YXRlOiBUdWUsIDIyIFNlcCAyMDI2IDE2OjE5OjA1ICswNTMwClN1YmplY3Q6IFtQQVRDSCBuZXQg
MS8yXSBuZXRmaWx0ZXI6IG5mX2Nvbm50cmFja19oMzIzOiBkbyBub3QgYnlwYXNzIE5BVAogaGVs
cGVycyB3aGVuIHR1cGxlIHNvdXJjZSBtYXRjaGVzIHJlcGx5IGRlc3RpbmF0aW9uCgpUaGUgZXhw
ZWN0YXRpb24gaGVscGVycyAoZXhwZWN0X2gyNDUsIGV4cGVjdF9ydHBfcnRjcCwgZXhwZWN0X3Qx
MjAsIGFuZApleHBlY3RfY2FsbGZvcndhcmRpbmcpIHRlc3Qgd2hldGhlciBOQVQgaXMgcmVxdWly
ZWQgYnkgY29tcGFyaW5nIHRoZQpmb3J3YXJkIHNvdXJjZSBJUCBhZ2FpbnN0IHRoZSByZXZlcnNl
IGRlc3RpbmF0aW9uIElQOgoKICAgIG1lbWNtcCgmY3QtPnR1cGxlaGFzaFtkaXJdLnR1cGxlLnNy
Yy51MywKICAgICAgICAgICAmY3QtPnR1cGxlaGFzaFshZGlyXS50dXBsZS5kc3QudTMsCiAgICAg
ICAgICAgc2l6ZW9mKGN0LT50dXBsZWhhc2hbZGlyXS50dXBsZS5zcmMudTMpKQoKVGhpcyBjaGVj
ayBpcyBicm9rZW4gZm9yIG11bHRpcGxlIHJlYXNvbnM6CgoxLiBJdCBpbmNvcnJlY3RseSBldmFs
dWF0ZXMgdG8gMCBpbiB0aGUgcmVwbHkgZGlyZWN0aW9uCiAgIChkaXIgPT0gSVBfQ1RfRElSX1JF
UExZKSBldmVuIHVuZGVyIFNOQVQsIGJlY2F1c2UgdHVwbGVoYXNoW1JFUExZXS5zcmMKICAgYW5k
IHR1cGxlaGFzaFtPUklHSU5BTF0uZHN0IGJvdGggcmVwcmVzZW50IHRoZSByZW1vdGUgcGVlcidz
IGFkZHJlc3MuCjIuIEluIERlc3RpbmF0aW9uIE5BVCAoRE5BVCkgYW5kIGhhaXJwaW4gc2V0dXBz
LCB0aGUgc2VuZGVyJ3Mgc291cmNlIElQCiAgIGlzIG5ldmVyIG1vZGlmaWVkLCBjYXVzaW5nIHRo
aXMgY2hlY2sgdG8gZXZhbHVhdGUgdG8gZmFsc2UgZXZlbiB0aG91Z2gKICAgTkFUIHBheWxvYWQg
cmV3cml0aW5nIGlzIG5lY2Vzc2FyeS4KCkFzIGEgcmVzdWx0LCBOQVQgcGF5bG9hZCBtYW5nbGlu
ZyBpcyBieXBhc3NlZCwgbGVhdmluZyBpbnRlcm5hbCBhZGRyZXNzZXMKdW50cmFuc2xhdGVkIGlu
c2lkZSB0aGUgc2lnbmFsaW5nIHBhY2tldHMgYW5kIGxlYWRpbmcgdG8gY2FsbCBzZXR1cCBhbmQK
bWVkaWEgc3RyZWFtIGZhaWx1cmVzLgoKUmVtb3ZlIHRoZSByZWR1bmRhbnQgbWVtY21wKCkgY2hl
Y2tzIGFjcm9zcyBhbGwgZm91ciBleHBlY3RhdGlvbiBoZWxwZXJzLgpWZXJpZnlpbmcgdGhhdCBu
YXRob29rIGlzIHByZXNlbnQgYW5kIHRoYXQgY3QtPnN0YXR1cyBtYXRjaGVzIElQU19OQVRfTUFT
SwppcyBzdWZmaWNpZW50IHRvIGRldGVybWluZSB3aGV0aGVyIE5BVCBoYW5kbGluZyBzaG91bGQg
ZXhlY3V0ZS4KCkZpeGVzOiBmNTg3ZGUwZTJmZWIgKCJbTkVURklMVEVSXTogbmZfY29ubnRyYWNr
L25mX25hdDogYWRkIEguMzIzIGhlbHBlciBwb3J0IikKQ2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5v
cmcKU2lnbmVkLW9mZi1ieTogU3ViaGFtIFBhbCA8c3ViaGFtcGFsNzg5QGdtYWlsLmNvbT4KLS0t
CiBuZXQvbmV0ZmlsdGVyL25mX2Nvbm50cmFja19oMzIzX21haW4uYyB8IDI0ICsrKysrKy0tLS0t
LS0tLS0tLS0tLS0tLQogMSBmaWxlIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKSwgMTggZGVsZXRp
b25zKC0pCgpkaWZmIC0tZ2l0IGEvbmV0L25ldGZpbHRlci9uZl9jb25udHJhY2tfaDMyM19tYWlu
LmMgYi9uZXQvbmV0ZmlsdGVyL25mX2Nvbm50cmFja19oMzIzX21haW4uYwppbmRleCA0Y2IxNjY1
YmJhMDIuLjBjMmFhNjA4YWU2MCAxMDA2NDQKLS0tIGEvbmV0L25ldGZpbHRlci9uZl9jb25udHJh
Y2tfaDMyM19tYWluLmMKKysrIGIvbmV0L25ldGZpbHRlci9uZl9jb25udHJhY2tfaDMyM19tYWlu
LmMKQEAgLTI1MCwxMiArMjUwLDkgQEAgc3RhdGljIGludCBleHBlY3RfcnRwX3J0Y3Aoc3RydWN0
IHNrX2J1ZmYgKnNrYiwgc3RydWN0IG5mX2Nvbm4gKmN0LAogCQkJICBJUFBST1RPX1VEUCwgTlVM
TCwgJnJ0Y3BfcG9ydCk7CiAKIAluYXRob29rID0gcmN1X2RlcmVmZXJlbmNlKG5mY3RfaDMyM19u
YXRfaG9vayk7Ci0JaWYgKG1lbWNtcCgmY3QtPnR1cGxlaGFzaFtkaXJdLnR1cGxlLnNyYy51MywK
LQkJICAgJmN0LT50dXBsZWhhc2hbIWRpcl0udHVwbGUuZHN0LnUzLAotCQkgICBzaXplb2YoY3Qt
PnR1cGxlaGFzaFtkaXJdLnR1cGxlLnNyYy51MykpICYmCi0JCSAgIG5hdGhvb2sgJiYKLQkJICAg
bmZfY3RfbDNudW0oY3QpID09IE5GUFJPVE9fSVBWNCAmJgotCQkgICBjdC0+c3RhdHVzICYgSVBT
X05BVF9NQVNLKSB7CisJaWYgKG5hdGhvb2sgJiYKKwkJbmZfY3RfbDNudW0oY3QpID09IE5GUFJP
VE9fSVBWNCAmJgorCQljdC0+c3RhdHVzICYgSVBTX05BVF9NQVNLKSB7CiAJCS8qIE5BVCBuZWVk
ZWQgKi8KIAkJcmV0ID0gbmF0aG9vay0+bmF0X3J0cF9ydGNwKHNrYiwgY3QsIGN0aW5mbywgcHJv
dG9mZiwgZGF0YSwgZGF0YW9mZiwKIAkJCQkJICAgIHRhZGRyLCBwb3J0LCBydHBfcG9ydCwgcnRw
X2V4cCwgcnRjcF9leHApOwpAQCAtMzEwLDEwICszMDcsNyBAQCBzdGF0aWMgaW50IGV4cGVjdF90
MTIwKHN0cnVjdCBza19idWZmICpza2IsCiAJZXhwLT5mbGFncyA9IE5GX0NUX0VYUEVDVF9QRVJN
QU5FTlQ7CS8qIEFjY2VwdCBtdWx0aXBsZSBjaGFubmVscyAqLwogCiAJbmF0aG9vayA9IHJjdV9k
ZXJlZmVyZW5jZShuZmN0X2gzMjNfbmF0X2hvb2spOwotCWlmIChtZW1jbXAoJmN0LT50dXBsZWhh
c2hbZGlyXS50dXBsZS5zcmMudTMsCi0JCSAgICZjdC0+dHVwbGVoYXNoWyFkaXJdLnR1cGxlLmRz
dC51MywKLQkJICAgc2l6ZW9mKGN0LT50dXBsZWhhc2hbZGlyXS50dXBsZS5zcmMudTMpKSAmJgot
CSAgICBuYXRob29rICYmCisJaWYgKG5hdGhvb2sgJiYKIAkgICAgbmZfY3RfbDNudW0oY3QpID09
IE5GUFJPVE9fSVBWNCAmJgogCSAgICBjdC0+c3RhdHVzICYgSVBTX05BVF9NQVNLKSB7CiAJCS8q
IE5BVCBuZWVkZWQgKi8KQEAgLTY0MywxMCArNjM3LDcgQEAgc3RhdGljIGludCBleHBlY3RfaDI0
NShzdHJ1Y3Qgc2tfYnVmZiAqc2tiLCBzdHJ1Y3QgbmZfY29ubiAqY3QsCiAJcmN1X2Fzc2lnbl9w
b2ludGVyKGV4cC0+YXNzaWduX2hlbHBlciwgbmZfY29ubnRyYWNrX2hlbHBlcl9oMjQ1X3B0cik7
CiAKIAluYXRob29rID0gcmN1X2RlcmVmZXJlbmNlKG5mY3RfaDMyM19uYXRfaG9vayk7Ci0JaWYg
KG1lbWNtcCgmY3QtPnR1cGxlaGFzaFtkaXJdLnR1cGxlLnNyYy51MywKLQkJICAgJmN0LT50dXBs
ZWhhc2hbIWRpcl0udHVwbGUuZHN0LnUzLAotCQkgICBzaXplb2YoY3QtPnR1cGxlaGFzaFtkaXJd
LnR1cGxlLnNyYy51MykpICYmCi0JICAgIG5hdGhvb2sgJiYKKwlpZiAobmF0aG9vayAmJgogCSAg
ICBuZl9jdF9sM251bShjdCkgPT0gTkZQUk9UT19JUFY0ICYmCiAJICAgIGN0LT5zdGF0dXMgJiBJ
UFNfTkFUX01BU0spIHsKIAkJLyogTkFUIG5lZWRlZCAqLwpAQCAtNzcwLDEwICs3NjEsNyBAQCBz
dGF0aWMgaW50IGV4cGVjdF9jYWxsZm9yd2FyZGluZyhzdHJ1Y3Qgc2tfYnVmZiAqc2tiLAogCXJj
dV9hc3NpZ25fcG9pbnRlcihleHAtPmFzc2lnbl9oZWxwZXIsIG5mX2Nvbm50cmFja19oZWxwZXJf
cTkzMV9wdHJbMF0pOwogCiAJbmF0aG9vayA9IHJjdV9kZXJlZmVyZW5jZShuZmN0X2gzMjNfbmF0
X2hvb2spOwotCWlmIChtZW1jbXAoJmN0LT50dXBsZWhhc2hbZGlyXS50dXBsZS5zcmMudTMsCi0J
CSAgICZjdC0+dHVwbGVoYXNoWyFkaXJdLnR1cGxlLmRzdC51MywKLQkJICAgc2l6ZW9mKGN0LT50
dXBsZWhhc2hbZGlyXS50dXBsZS5zcmMudTMpKSAmJgotCSAgICBuYXRob29rICYmCisJaWYgKG5h
dGhvb2sgJiYKIAkgICAgbmZfY3RfbDNudW0oY3QpID09IE5GUFJPVE9fSVBWNCAmJgogCSAgICBj
dC0+c3RhdHVzICYgSVBTX05BVF9NQVNLKSB7CiAJCS8qIE5lZWQgTkFUICovCi0tIAoyLjQzLjAK
Cg==
--000000000000c160c7065c1ed789--
