Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794259564;
	b=sNds3p9o+8Br8Xb33IoPmAGu9ClBkXjxL3trPQJT2Ntpl9E6V8iX/Rff7ktq5W2RrjST
	 aCUqsDkEghkfaY4k50NHTZ2+8yoKyN05WFCjfIb3JB9W46r6t5BYlP7MrBlouL8xFOv6q
	 wSKWYq9Qp84y5+A4qrqieNnpYgnnurDdzBh1BIzZDNuw7qJCK43vQSAMakjWc9dZoWWyF
	 YWlanI7IMffc8f4kV7I9nt45kmLNG1lCe++JmifeKT6h2bpL9TVLENRSW8JJsdjK5GWzs
	 Jp0BfZ9MbeGbaG4TiJAa7kNZ76nw7Vr5XyorsjNa3++i0mWWnlUXk/jylSZaLkmGiaw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794259564;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Tjw56/pLVUPC5w8Tq75N+AiMEtXwfP+dxZK4YdW5KOQ=;
	b=sNbzoXh0k1PtcwypxvRYGwttdflPPyp5yQpdcJkNprh71mHC6s7YzP9JWuSYUuWBcvQJ
	 m6rQyna6f+4j+VzFQ9qtQjJfNOI048TW0QpiDHSBTaaJpriQedsGGAr/Xunpy0sKEhXJH
	 NLzL2OgmNsCRVAtHI41HAhcXL2NfqTaLyxhRPGz/jCw/VN29b2++kfcp+z5B3b8eEJytd
	 3bI0pvvWrjAwNY8PTKehXoHfKUWvOgOOuq/RNL9xGese0WYfRWyvoPYDvsS9sRmcNCeD1
	 0kqAJqkc7lOZg9ZO6hC0+0+H2SGTmm9znBitrn+fuAjOPhBaSkjfK2a8e6vKnedqGaQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=networkplumber.org;
	spf=pass smtp.mailfrom=networkplumber.org;
	dkim=pass header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b="m/xpnqin";
	arc=none smtp.remote-ip=209.85.210.181
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56CA6606A331
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 21:26:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 56CA6606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=m/xpnqin
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-8b271e573adso517489b3a.2
        for <netdev@vger.kernel.org>; Mon, 09 Nov 2026 13:26:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20260707.gappssmtp.com; s=20260707; t=1794259564; x=1794864364; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Tjw56/pLVUPC5w8Tq75N+AiMEtXwfP+dxZK4YdW5KOQ=;
        b=m/xpnqin0iZZp45oS/YHzOmIxzIiGKYZEWPT15P4U9wekahsD8tZDosxo82uUUJZhe
         mA1nAnI1Gdh72lpa8KrA7GI7DJhHQAy8fugzl9++B2+e42wrWUznNrx1plpWff4xnO0O
         WpZ8UfULLV9+zGc9n2aU+OYxMmb4W7zXodaxc+YkpDrY9hwvsxuAaBSFzx9p2sk9uuiO
         kg/n23ItZwQiWJwOxBeDH05UQuukZ/4/dYGvnN5ZgTmkjaGF/C/STUwlJdlBzwV8bUGD
         bZH0/YH+MPbxAzSYxyVzmXtnRYKleHOhUs5ZBVefoIVRaCvFV5C7xMJMBVSXFkndd1w/
         bWpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794259564; x=1794864364;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Tjw56/pLVUPC5w8Tq75N+AiMEtXwfP+dxZK4YdW5KOQ=;
        b=sOdVhhQs/zwFT1mqyjvElH7VY53VL0yguj85VHTQjtNpkQVBgRnYDVKNRXsO5c7CK0
         aXy+f0CxZvGtNAKcJIyDJC5TBYwqc894rQTow1acahMUuoKil+ah4R8HtcriN11k6sqQ
         pgQOkyCM8VeQ5TLfz+oDAGhF4Xlq6PfUF0ay75cPxev34GD1OsOQJQHxHZHwB/aibrXM
         Ze9GYi8Z8W7VO5CuAmb0zCOb1uEPYmjXhPOhLYPTwM+8q1XybOGsOWZmeMKCf+odPWGs
         pwo12tYDYumAX95Jxvo+qiSrsncTNUmcka0Aalq0/yqHBYqJw+ECC+4bYMoupJhBVACu
         kCXg==
X-Gm-Message-State: APuU4Z8TQofl9brA43BnuXaU2FY+UeSz5peNm8oXPxxIdxeDV5l/69nb
	APg+8V3+Gr+iHIHE75zq1Zt5bIxMfhH//WwBVUVlBVlqF89jasMpaqDvCZSF5rvdca2aMUUm+k8
	ODKWyZh8=
X-Gm-Gg: AYBFou14tYbUzQmYJ/zojUK/H3JV11nFHHZSCu3n8pj3J1Tfq2UChGL6Qvy/RoJa2ia
	tDh4+S/fMXs7IIuwyHK3JNHNdu4rzH3qL5gtFVY5FsG7r6V8oIJ24HqxmZnu10pA5vQ3SzlctL8
	djVf0RDzgfFKpoihUzmF3oBocTF6Ydm5caHc7CWogFC95XFhPL9lu5urwJCh0y0gEm549eOfzzh
	VLkuSSh4zbnJORKBGSfMB/gLFwuGh1+fLF0UY8ZiZik3fBQUM2Hik3pKgS0mhJH+/RIlqeEXgiS
	2M3Dx6HEeDqLpvJ0LJWP6n/VknnuDl0CdI0zSwdlVijl2zyF0m0fFa5HaAzhWtB34XAW5le7kKK
	hUjg8azkEWFDaNE3ES4k03MBEHF4TKMpGgXGzvVPvFNL8HAEJpkwY7pXy/Ti8AWZS2VgBAxC5bc
	WCauL+M1Kaj4uUOVfwPBV1nYlYSqCnMM9qQ10bV+3pkDH0/xCfLyM1n9xpZRBfq9j8/0CmOxsPr
	DdalR5ScJewhmMhuzbcgL5Xl4INNJEPmUZ6uxKQaS6xJ8QPlcRSgKjMV46LsLu9hFjKPBMnYWsn
	kZBS0HaV//Bzm8YQIh9Kl57elPjc56wOd1sBZyyq+n+v1SePG7EFlXc/QRy3IZZ32SAm
X-Received: by 2002:a05:6a00:1898:b0:882:1b4d:1840 with SMTP id d2e1a72fcca58-8ba867aaed4mr820967b3a.24.1794259563680;
        Mon, 09 Nov 2026 13:26:03 -0800 (PST)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8baa7de3619sm122854b3a.5.2026.11.09.13.26.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 13:26:03 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: dsahern@kernel.org,
	Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH iproute2 01/11] ss: fix double close on sock_diag send failure
Date: Mon,  9 Nov 2026 13:25:17 -0800
Message-ID: <20261109212559.39661-2-stephen@networkplumber.org>
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

If sendmsg() fails, tcpdiag_send() and sockdiag_send() close the
netlink socket, then inet_show_netlink() closes it again via
rtnl_close(). The second close clobbers errno with EBADF.

Leave closing the socket to the caller.

Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 misc/ss.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/misc/ss.c b/misc/ss.c
index cffee883..674ed8e8 100644
--- a/misc/ss.c
+++ b/misc/ss.c
@@ -3931,10 +3931,8 @@ static int tcpdiag_send(int fd, int protocol, struct filter *f)
 		.msg_iovlen = iovlen,
 	};
 
-	if (sendmsg(fd, &msg, 0) < 0) {
-		close(fd);
+	if (sendmsg(fd, &msg, 0) < 0)
 		return -1;
-	}
 
 	return 0;
 }
@@ -4026,7 +4024,6 @@ static int sockdiag_send(int family, int fd, int protocol, struct filter *f)
 
 	if (sendmsg(fd, &msg, 0) < 0) {
 		free(bpf_rta);
-		close(fd);
 		return -1;
 	}
 
-- 
2.53.0

