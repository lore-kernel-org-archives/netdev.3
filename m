Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794259575;
	b=FVS8TK9WyjN6+0Mi/9fdRz2yn5LCimTSNSql79/jbFI22EOA/T7+6RNeSZmBHfOolgqn
	 1bb/9Z+CLq7GqZDEo335OEspbcyWRkHNZ1VhqioUw/nDUJHl2mKiNo4TKGrT8QjdRQS0c
	 gajLFSixdElsiekQujIGbWkSTBdwv6gzSrh6wbVfJAtvXCJHT/yi524+NGLJRRE2nDFGC
	 m3pDDqvMnI8AM5RzfBk7At7+stnBSXDyJF7kF+x5pfpZGpHP7OplHiUt3UA41AHeBGP/4
	 /oHj+zEwmh+t/ABS3IqTt0kFXfjo3+oOIsLbFxWh6PRYcyAvP15u31F1MvSTp5F5Q7Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794259575;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=r5Tg8CUsGjc4gowf5FMDuTLAxDmofqPdRVJiV82/u/c=;
	b=bxuEl8yLx1jEfqdl9a2y0/h2kyFOlfibMx7ZrAdJfZ0Tkfadj0FXerzEohZ/ALynC6BL
	 29HTwAnMNUtiO4RtajMs4vDz8Ua4XtiBpvQgV6j5MQINxnWP9Rx0weey160XbkJw4vGmJ
	 lWtAzhCOmcWndJQU32bj0dD/AQr+HR4Ct82W4MY2NxIs8WOny6ENOR648HmY4r0iMfU/T
	 t/RuratgyyFvlUnt0VAumKdezarcweZ6aN5c3BZLlquhSKsOJEyeqXm9s8k1BtBnMaqf9
	 iiUeAoIO73nLOABnf+fTY8x6pm/tVeu0Xulcqli4BBCp5IgwKr/Sx6H2H1uoFEhLgUQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=networkplumber.org;
	spf=pass smtp.mailfrom=networkplumber.org;
	dkim=pass header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=gvSKETv5;
	arc=none smtp.remote-ip=209.85.210.175
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A05D7606A330
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 21:26:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A05D7606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=gvSKETv5
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-8a05b210703so663502b3a.0
        for <netdev@vger.kernel.org>; Mon, 09 Nov 2026 13:26:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20260707.gappssmtp.com; s=20260707; t=1794259574; x=1794864374; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=r5Tg8CUsGjc4gowf5FMDuTLAxDmofqPdRVJiV82/u/c=;
        b=gvSKETv53YQBswraxwn4lk6XFqX3nhDxuYqPngDS8cTmiWPmzfHhj6KVQit9tAs9QT
         ge9AxJjf2btzDt0LjV5haFcjWcSrhFLLDzCUvtie9TAqBlLDxWqF899xHXWBwSlSjVy+
         O3YQT1+TMrolIAhPUXIE9P7mdjj7pgoWq6d9Alkgq+gmtYHnhCHPzU187G3qghSNMUBX
         uMzd0pe+tNkUCIERJDAJGAVqiHdUrnPWv9/DZJLP61DxgTBiSVctsOKxzKYwAWLZ/0NP
         YPY8q4vNUo9iFpud6xDgO6x4h3pr+jKzdM+ksKze/gPfOkju7bnRS02Nw/l8HvkBZnGg
         W46g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794259574; x=1794864374;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=r5Tg8CUsGjc4gowf5FMDuTLAxDmofqPdRVJiV82/u/c=;
        b=Nx9zAMb2yjk8GCV5U2DRG/Gc+RMwDuhEsHeQWKagPuPKt2TRlglbwIgCxNUYmK4kgs
         71LV4pC+L0igeD5TfSnRx9o9ry8lNSCFOQTX7vWS77JPCFa8Qzw3kk7w5TddDEtm+Fpe
         czVGrQldazA3BWkY63pJ/EpEWjSzTjHIQSVxWKDuu7MQNvjHLoMbNZ9Gkjd2WCt+AK6a
         XrnDn5npZSuZtG9DK6WjPxbEd4Fulnqqs6Q1PP+fqmxmZ4Dv3u/h9uGaQx0FQHOErK2N
         /9ZYtNIgYSIGkT0lUF4tAj+p23gNKGnYEhSPRGsOeIcTE9ESkji8NfXLB3UuZDnDYd+y
         9z6g==
X-Gm-Message-State: APuU4Z8zi/ullEjLCar9oJy02NsZpx4C3KF6lsJ25931lGB63GpoJJFI
	kTKHg5KsMSyh2HxzgXRBcogx37qpgrPVwIajnTwhrSMTiti3d8yeoYsOtY2u69zyeIfQ+qRRgY+
	40NvrXwA=
X-Gm-Gg: AYBFou3dc/OLEeZfe/iIX5EG2+ObPgjQKfbSLqEXZ3RNBqKq22R5/niMu7Ab9gzAmgt
	3jSR4xdf4AY02ut+7M6ZBgcx8t50IEvBMxiy9Vi/UxRq7+qkq4uSgIrqMnHudwYNkReWMvNSHS/
	TyC1JBkn5rx3I5/jbe4b/lTpSLghmfI5oiRJya9ylPDGYc3kO6H3A9As+leoIPPR/Lb68FUJsFW
	WkUknX0+n5ebhVDgJAsOjWk0565K+2dhW0EpCGTcchdkV6yQWJD0TsHT7MlDX2pTTyYZvvUzBEI
	oRhQEdPhZzE5qvtTOHXzFqa3xKQxY6ohHMUBmSsMaF6gO0clL2jpFWNHN1D6cDQlJ4eTKROaBic
	jELo+YG8SaziMAKczHozVWNaQdOju4f+N6L4EckSR6WnC9zfPudTUKlpKPOxKoTFivsWQH+RiGF
	ul3xjE8HBv7MNiYVmhLRVHXjlSMnzTRGVhxlEdDo7F8IoUGvT6eybmYva+KmiZvudO6/wTUNG8y
	famgNuYtDzt6b4e4D96U4bwaWFMOgmH+o/NO3cEjpQ0jf1C+bCvbBY7MxqbL1fG0CmdosNO/J67
	T/kLh3o0rJLOZ84mXTAh+5DD+Fy7SzgY4UoigT6qqgjCZcUxBkh7OgT7+EzpwviQNwBG
X-Received: by 2002:a05:6a00:812:b0:886:18b2:361c with SMTP id d2e1a72fcca58-8ba82679c7cmr844999b3a.7.1794259573985;
        Mon, 09 Nov 2026 13:26:13 -0800 (PST)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8baa7de3619sm122854b3a.5.2026.11.09.13.26.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 13:26:13 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: dsahern@kernel.org,
	Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH iproute2 10/11] ss: keep following events after ENOBUFS
Date: Mon,  9 Nov 2026 13:25:26 -0800
Message-ID: <20261109212559.39661-11-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109212559.39661-1-stephen@networkplumber.org>
References: <20261109212559.39661-1-stephen@networkplumber.org>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ss -E exited when a burst of socket closes overflowed its receive
queue. Lost events are not fatal, so keep listening, as
rtnl_listen() does.

With -K the second socket, used only to send SOCK_DESTROY, also
joined the event groups and its queue filled up unread. Open it
without groups.

Reported-by: Anthropic OSS scanner (ANT-2026-39AYDLBX)
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 misc/ss.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/misc/ss.c b/misc/ss.c
index 2f7c891a..55d9ae00 100644
--- a/misc/ss.c
+++ b/misc/ss.c
@@ -5089,14 +5089,19 @@ static int handle_follow_request(struct filter *f)
 	rth.local.nl_pid = 0;
 
 	if (f->kill) {
-		if (rtnl_open_byproto(&rth2, groups, NETLINK_SOCK_DIAG)) {
+		/* Only used to send SOCK_DESTROY, must not get the events */
+		if (rtnl_open_byproto(&rth2, 0, NETLINK_SOCK_DIAG)) {
 			rtnl_close(&rth);
 			return -1;
 		}
 		f->rth_for_killing = &rth2;
 	}
 
-	if (rtnl_dump_filter(&rth, generic_show_sock, f))
+	/* ENOBUFS means events were lost, keep listening */
+	do {
+		ret = rtnl_dump_filter(&rth, generic_show_sock, f);
+	} while (ret == -ENOBUFS);
+	if (ret)
 		ret = -1;
 
 	rtnl_close(&rth);
-- 
2.53.0

