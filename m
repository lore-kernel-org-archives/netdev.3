Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1B961DF261
	for <netdev@vger.kernel.org>; Sun, 11 Oct 2026 08:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791706015; cv=pass; b=Eqc737Sei8RkXMys2zlkvjqWjBOcy32DkkDjDdVRyPe8nKRR6kGp5uyKOiso2P2cpqcSyNF02vip/jjFOIN+lyvKotMw2amotZHIpEZX94KEASwKasMSkYM3cdFPSRK+j55TspyjwUcp0MC0G2xEZ2qbmZKkaLdf9rRZL7jAJQE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791706015; c=relaxed/simple;
	bh=6aXpQYP46dxGTYi+5Rh0s/w8vni2Pd2debIdTuL+MDY=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=GOFiJ0iuYiNyFNMPkUF0lms17z8JS5Ac0/+ybaeOgqtvCmR16eMazBQKHu56dcll7eM2VTftd+u55hC0DfVJAEsueB0ISSITBFZa/CA4LkVAyxeuRo8zv/xlEWteTSaSKBNmyPX6bQes79m155kJ1QpApUwB18O3UrNsvyZSp8w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F7JeozOO; arc=pass smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F7JeozOO"
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-82395ae2ea8so829448a34.1
        for <netdev@vger.kernel.org>; Sun, 11 Oct 2026 01:06:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791706013; cv=none;
        d=google.com; s=arc-20260327;
        b=Hu7Pqb8HRRbGIXAz4o76kmRURs56GkWRwF2KoF1mfJzuv9YmGIJxlw6Bnbq3fSQU41
         KAxXgwBFgJ5GU5w2kQScViaUSk9P2qinBN2NOF3hc4kjM7rJzDVEtDDsB8ybP9j3fINv
         vD57e6MUN9R3QRHvFIP+tENIlUSpFHs7zfhMEu2vsWCX0wnZy/FDnWi7GQNTlUZgxsP3
         IDIa6yxoCVUqbTo/npHJMxrm83/napYB5zRdOEeih1Y2HwA+kTjmg568oZvCtXp5ZN+x
         DWlRp/sxUv9p+i85zCMA0XPs/nFHgsWr5e6UNBMRY+v00MVQgMfa1UUoRnVGsLY3+45S
         bVxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=OL+zaVIM3R7+O8WxM9K+yPr2Z4/rZeDvZlr73pxdddQ=;
        fh=CGq1OwkR/bB2tCMTYn+dNlc7J9EMuoRhvOTFkAwhCbY=;
        b=D6Fp84coA/90meEtK6LQ3ibr5QFWUXv8fv4DBu6k2YBH8fbOJXNiFVjSQfSwydxkHy
         j3Xs4QaGwS7yN9I34gcrrdxGgElu8oZPrauDqhlapCAnlsP+QBlnCZVqODwuOr509Jky
         +8I+lnsiZTMPiApA78V/sO0k5IznDz+yAzynIRpeV+dbuDdrvE8T+WLYto6jJBvOCMvc
         XTNooY3LaLSUNmN2ebX3naZ+r9IPJHCAUCceH51B9nG/xsO8m5Z2XmBztb6IoyYzQZLU
         ZvzRtDn8T1dH9EkbKcAyHyASeL8OQnvq0r585kMxMKxMwodlxfBLZZYIqdTWdDfZffL3
         53nA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791706013; x=1792310813; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=OL+zaVIM3R7+O8WxM9K+yPr2Z4/rZeDvZlr73pxdddQ=;
        b=F7JeozOObgoYKtiGpwWWrOXrywUBqfESIM18N+2ArDye7Q6E//lRhZG8kUPOPXqvIY
         /VlZVWwJyNy3JrJe4MsEt48vfsBiRiTIQhlSTeyTmDZOwYBr/epDxzytz2EdKl1meKfP
         ugecl0Ted3XVtBTX7WI1ztfbpVpJHGpbAM14TwO3x9aEmRCjU7skLavg/zDJfdaRa1f1
         TcAaZgqfJuZ2mqhF+8xjA/uf5Mpo3femo1jZ2a44Enmi2ptlEzAe2SQD6kXISxM/YZTb
         32NJ4k70NNsqiFExcaHVQh3pIuRSZQTt949Rrjhh3EfzIgwBLnMu4ECESTJ9hCUFPOLk
         TDmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791706013; x=1792310813;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=OL+zaVIM3R7+O8WxM9K+yPr2Z4/rZeDvZlr73pxdddQ=;
        b=vU6j9mJ6nyR67baPPgqeUPaC0tdAEa7ePGd6DPKVE/KzO8zDH0KV3HoMZeofK9O3t/
         5uQ4jhF1dgjSzCn1rhl6mQSbuRI4UOPtekvvATtmh+QzadoMLvpM2O0ykdG17N/RyPTv
         B6sIFKbsXltgll/8UtQ1qm8ADit2Ef43J1oQEpGStbMc1ceOiyH19BwTgNo2DptsQs7v
         9VxDqexYV/Y5P3yfWc9KC3Tc1LaMzr7paTZivThsph/ILOvS+yHt9I18pE27/zUQYAYY
         3/frZjjPwQvdkhHVeIndjF5DfaxG5bZ6OKjrdKoeGhBNh9iL+ryGC3C97qL1FCCkCucC
         NxXw==
X-Gm-Message-State: AFq9FYJ3msKenP82bcZ7ydLYFGYejSWXna8jY7u8nj7ccLUITdmObSen
	62Tbyu3VZmlmbqIm2+1ZqoIrc0LMAIe15acREXTi9iO33yBEsf5PeNDwiR4TW8KjlEJrcAbLIfW
	GBGHhe79bXYkRGy4AWx8XA5AEB6VRiiaqhgav
X-Gm-Gg: AYBFou2NSUfb12jA6FSo7XaHej3aZbz2XtY9487vuUyDXWQwB5HVX1jkfmEGmM8x/QQ
	G8GKYxmcGLVAa4wRxDfLebU7KJwskLyDDsmAUqKk27jRI3dpU1QUH5qy5FAOfvtfJIaxWwKJA1J
	4cBsgwD9WWNSw3NEpLs+Ur2FCsrXdUPhgEn5Xq7MB8WC8MryaUEw0gRZs6yIkIq4OkNqgWN19Yh
	3jMLwRePmK9aBWSOg73JEdH2r3cjxRQI97DGfqggQ8LDWkeqDpyNEHEEz8q+ROn7EtgYyvw/c5O
	6IeNUnpWV/AqXU37LDIAlow73BCE0XvX58PRCggBNWu5fIEXIU+krrbfuQxI4UcWVYyA6o2dYdv
	NNcI1cj7WHd0zTxCLsPgqiNb8d8JlrCxqJPKSuj/6IIT07XArTQvMTsBb
X-Received: by 2002:a05:6808:6716:b0:4fb:f1d7:932a with SMTP id
 5614622812f47-50c4245dcd9mr5563642b6e.3.1791706013310; Sun, 11 Oct 2026
 01:06:53 -0700 (PDT)
Received: from 138594053405 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 11 Oct 2026 04:06:52 -0400
Received: from 138594053405 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 11 Oct 2026 04:06:52 -0400
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Adrian Martinez Garcia <adrimg3196@gmail.com>
Date: Sun, 11 Oct 2026 04:06:52 -0400
X-Gm-Features: AclHuK9TU8b2rN6JCpHLRP9-F6-HiKDTDa9Qgjw7AcxhxFe7ScISAZ0jb0Z6ApI
Message-ID: <CACO1+RRid9tJq81weX-UHj6111gGZ_H1RMnxk66dtGZfwxoXRw@mail.gmail.com>
Subject: [PATCH] xfrm: account XFRMA_IF_ID and XFRMA_OFFLOAD_DEV in msgsize helpers
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000773ad0065d8c109e"

--000000000000773ad0065d8c109e
Content-Type: text/plain; charset="UTF-8"

Hi,

The xfrm_acquire_msgsize(), xfrm_polexpire_msgsize() and xfrm_expire_msgsize()
helpers do not account for the XFRMA_IF_ID (8 B) and XFRMA_OFFLOAD_DEV
(12 B) attributes that their sibling builders emit. The deficit of up to
20 B can trigger BUG_ON(err < 0) in the callers -> latent kernel panic.

This is a sibling of CVE-2026-43107 (fix 7081d46d32 only corrected the
aevent pair; these three pairs were left unfixed).

Fixes: 7e6526404ade
Signed-off-by: Adrian Martinez <adrimg3196@gmail.com>

I used Claude Code to help with the audit.

--000000000000773ad0065d8c109e
Content-Type: application/octet-stream; 
	name="0001-xfrm-account-XFRMA_IF_ID-and-XFRMA_OFFLOAD_DEV.patch"
Content-Disposition: attachment; 
	filename="0001-xfrm-account-XFRMA_IF_ID-and-XFRMA_OFFLOAD_DEV.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f7fe3f3290ab5c0b_0.1

RnJvbSA1MzRjYjJiNWZiOGRhODE2NzdmMjk1NWFhYzhhOThkOWFhODk2OTRiIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBZHJpYW4gTWFydGluZXogPGFkcmltZzMxOTZAZ21haWwuY29t
PgpEYXRlOiBTdW4sIDExIE9jdCAyMDI2IDA2OjUzOjMxICswMDAwClN1YmplY3Q6IFtQQVRDSF0g
eGZybTogYWNjb3VudCBYRlJNQV9JRl9JRCBhbmQgWEZSTUFfT0ZGTE9BRF9ERVYgaW4KIGFjcXVp
cmUvcG9sZXhwaXJlL2V4cGlyZSBzaXplIGNhbGN1bGF0aW9ucwoKeGZybV9zZW5kX2FjcXVpcmUo
KSBhbmQgeGZybV9leHBfcG9saWN5X25vdGlmeSgpIGFsbG9jYXRlIHRoZWlyIHJlcGx5IHNrYgp3
aXRoIHhmcm1fYWNxdWlyZV9tc2dzaXplKCkgYW5kIHhmcm1fcG9sZXhwaXJlX21zZ3NpemUoKSwg
dGhlbiBidWlsZF9hY3F1aXJlKCkKYW5kIGJ1aWxkX3BvbGV4cGlyZSgpIGFwcGVuZCBhdHRyaWJ1
dGVzIGluY2x1ZGluZyBYRlJNQV9JRl9JRCAod2hlbiB0aGUKcG9saWN5IGlmX2lkIGlzIHNldCkg
YW5kIFhGUk1BX09GRkxPQURfREVWICh3aGVuIHRoZSBwb2xpY3kgaXMgYm91bmQgdG8gYW4KeGZy
bSBvZmZsb2FkIGRldmljZSkuICBOZWl0aGVyIHNpemUgaGVscGVyIHJlc2VydmVzIHNwYWNlIGZv
ciB0aGVzZSB0d28KY29uZGl0aW9uYWxseSBlbWl0dGVkIGF0dHJpYnV0ZXMsIHNvIGZvciBwb2xp
Y2llcyBjYXJyeWluZyBpZl9pZCwgbWFyaywKcGNwdSBhbmQvb3IgYW4gb2ZmbG9hZCBkZXZpY2Ug
dGhlIGJ1aWxkZXJzIGNhbiBydW4gb3V0IG9mIHNrYiB0YWlscm9vbSwKZmFpbCB3aXRoIC1FTVNH
U0laRSBhbmQgaGl0IEJVR19PTihlcnIgPCAwKSwgdHVybmluZyBhIG5ldGxpbmsgZXZlbnQgaW50
bwphIGtlcm5lbCBwYW5pYy4KCmJ1aWxkX2V4cGlyZSgpIGhhcyB0aGUgc2FtZSBYRlJNQV9JRl9J
RCB1bmRlcmNvdW50IGluIHhmcm1fZXhwaXJlX21zZ3NpemUoKTsKaXRzIGNhbGxlciBhbHJlYWR5
IGhhbmRsZXMgLUVNU0dTSVpFIGdyYWNlZnVsbHksIHNvIHRoZSBvbmx5IGVmZmVjdCB0aGVyZQpp
cyBhIGRyb3BwZWQgRVhQSVJFIG5vdGlmaWNhdGlvbi4KClRoaXMgaXMgdGhlIHNhbWUgYnVnIGNs
YXNzIGFzIENWRS0yMDI2LTQzMTA3LCB3aG9zZSBmaXggKDcwODFkNDZkMzIpCm9ubHkgY292ZXJl
ZCB0aGUgYWV2ZW50IHBhaXIuCgpBY2NvdW50IFhGUk1BX0lGX0lEIGFuZCBYRlJNQV9PRkZMT0FE
X0RFViBpbiB0aGUgdGhyZWUgc2l6ZSBjYWxjdWxhdGlvbnMKdW5jb25kaXRpb25hbGx5LCBhbmQg
cmVwbGFjZSB0aGUgdHdvIEJVR19PTnMgd2l0aCBub3JtYWwgZXJyb3IgdW53aW5kaW5nLAptaXJy
b3JpbmcgdGhlIGFldmVudCBmaXguCgpGaXhlczogN2U2NTI2NDA0YWRlICgieGZybTogQWRkIGEg
bmV3IGxvb2t1cCBrZXkgdG8gbWF0Y2ggeGZybSBpbnRlcmZhY2VzLiIpClNpZ25lZC1vZmYtYnk6
IEFkcmlhbiBNYXJ0aW5leiA8YWRyaW1nMzE5NkBnbWFpbC5jb20+Ci0tLQogbmV0L3hmcm0veGZy
bV91c2VyLmMgfCAxNyArKysrKysrKysrKysrKy0tLQogMSBmaWxlIGNoYW5nZWQsIDE0IGluc2Vy
dGlvbnMoKyksIDMgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvbmV0L3hmcm0veGZybV91c2Vy
LmMgYi9uZXQveGZybS94ZnJtX3VzZXIuYwppbmRleCBhMjU4N2M3ZS4uNWViNzliMGIgMTAwNjQ0
Ci0tLSBhL25ldC94ZnJtL3hmcm1fdXNlci5jCisrKyBiL25ldC94ZnJtL3hmcm1fdXNlci5jCkBA
IC0zOTI3LDcgKzM5MjcsOCBAQCBzdGF0aWMgaW5saW5lIHVuc2lnbmVkIGludCB4ZnJtX2V4cGly
ZV9tc2dzaXplKHZvaWQpCiAJcmV0dXJuIE5MTVNHX0FMSUdOKHNpemVvZihzdHJ1Y3QgeGZybV91
c2VyX2V4cGlyZSkpICsKIAkgICAgICAgbmxhX3RvdGFsX3NpemUoc2l6ZW9mKHN0cnVjdCB4ZnJt
X21hcmspKSArCiAJICAgICAgIG5sYV90b3RhbF9zaXplKHNpemVvZl9maWVsZChzdHJ1Y3QgeGZy
bV9zdGF0ZSwgZGlyKSkgKwotCSAgICAgICBubGFfdG90YWxfc2l6ZSg0KTsgLyogWEZSTUFfU0Ff
UENQVSAqLworCSAgICAgICBubGFfdG90YWxfc2l6ZSg0KSArIC8qIFhGUk1BX1NBX1BDUFUgKi8K
KwkgICAgICAgbmxhX3RvdGFsX3NpemUoNCk7IC8qIFhGUk1BX0lGX0lEICovCiB9CiAKIHN0YXRp
YyBpbnQgYnVpbGRfZXhwaXJlKHN0cnVjdCBza19idWZmICpza2IsIHN0cnVjdCB4ZnJtX3N0YXRl
ICp4LCBjb25zdCBzdHJ1Y3Qga21fZXZlbnQgKmMpCkBAIC00MTc3LDYgKzQxNzgsOCBAQCBzdGF0
aWMgaW5saW5lIHVuc2lnbmVkIGludCB4ZnJtX2FjcXVpcmVfbXNnc2l6ZShzdHJ1Y3QgeGZybV9z
dGF0ZSAqeCwKIAkgICAgICAgKyBubGFfdG90YWxfc2l6ZShzaXplb2Yoc3RydWN0IHhmcm1fbWFy
aykpCiAJICAgICAgICsgbmxhX3RvdGFsX3NpemUoeGZybV91c2VyX3NlY19jdHhfc2l6ZSh4LT5z
ZWN1cml0eSkpCiAJICAgICAgICsgbmxhX3RvdGFsX3NpemUoNCkgLyogWEZSTUFfU0FfUENQVSAq
LworCSAgICAgICArIG5sYV90b3RhbF9zaXplKHNpemVvZih4cC0+aWZfaWQpKSAvKiBYRlJNQV9J
Rl9JRCAqLworCSAgICAgICArIG5sYV90b3RhbF9zaXplKHNpemVvZihzdHJ1Y3QgeGZybV91c2Vy
X29mZmxvYWQpKSAvKiBYRlJNQV9PRkZMT0FEX0RFViAqLwogCSAgICAgICArIHVzZXJwb2xpY3lf
dHlwZV9hdHRyc2l6ZSgpOwogfQogCkBAIC00MjM2LDcgKzQyMzksMTAgQEAgc3RhdGljIGludCB4
ZnJtX3NlbmRfYWNxdWlyZShzdHJ1Y3QgeGZybV9zdGF0ZSAqeCwgc3RydWN0IHhmcm1fdG1wbCAq
eHQsCiAJCXJldHVybiAtRU5PTUVNOwogCiAJZXJyID0gYnVpbGRfYWNxdWlyZShza2IsIHgsIHh0
LCB4cCk7Ci0JQlVHX09OKGVyciA8IDApOworCWlmIChlcnIgPCAwKSB7CisJCWtmcmVlX3NrYihz
a2IpOworCQlyZXR1cm4gZXJyOworCX0KIAogCXJldHVybiB4ZnJtX25sbXNnX211bHRpY2FzdChu
ZXQsIHNrYiwgMCwgWEZSTU5MR1JQX0FDUVVJUkUpOwogfQpAQCAtNDMwNyw2ICs0MzEzLDggQEAg
c3RhdGljIGlubGluZSB1bnNpZ25lZCBpbnQgeGZybV9wb2xleHBpcmVfbXNnc2l6ZShzdHJ1Y3Qg
eGZybV9wb2xpY3kgKnhwKQogCSAgICAgICArIG5sYV90b3RhbF9zaXplKHNpemVvZihzdHJ1Y3Qg
eGZybV91c2VyX3RtcGwpICogeHAtPnhmcm1fbnIpCiAJICAgICAgICsgbmxhX3RvdGFsX3NpemUo
eGZybV91c2VyX3NlY19jdHhfc2l6ZSh4cC0+c2VjdXJpdHkpKQogCSAgICAgICArIG5sYV90b3Rh
bF9zaXplKHNpemVvZihzdHJ1Y3QgeGZybV9tYXJrKSkKKwkgICAgICAgKyBubGFfdG90YWxfc2l6
ZShzaXplb2YoeHAtPmlmX2lkKSkgLyogWEZSTUFfSUZfSUQgKi8KKwkgICAgICAgKyBubGFfdG90
YWxfc2l6ZShzaXplb2Yoc3RydWN0IHhmcm1fdXNlcl9vZmZsb2FkKSkgLyogWEZSTUFfT0ZGTE9B
RF9ERVYgKi8KIAkgICAgICAgKyB1c2VycG9saWN5X3R5cGVfYXR0cnNpemUoKTsKIH0KIApAQCAt
NDM1OCw3ICs0MzY2LDEwIEBAIHN0YXRpYyBpbnQgeGZybV9leHBfcG9saWN5X25vdGlmeShzdHJ1
Y3QgeGZybV9wb2xpY3kgKnhwLCBpbnQgZGlyLCBjb25zdCBzdHJ1Y3QKIAkJcmV0dXJuIC1FTk9N
RU07CiAKIAllcnIgPSBidWlsZF9wb2xleHBpcmUoc2tiLCB4cCwgZGlyLCBjKTsKLQlCVUdfT04o
ZXJyIDwgMCk7CisJaWYgKGVyciA8IDApIHsKKwkJa2ZyZWVfc2tiKHNrYik7CisJCXJldHVybiBl
cnI7CisJfQogCiAJcmV0dXJuIHhmcm1fbmxtc2dfbXVsdGljYXN0KG5ldCwgc2tiLCAwLCBYRlJN
TkxHUlBfRVhQSVJFKTsKIH0KLS0gCjIuNDMuMAoK
--000000000000773ad0065d8c109e--
