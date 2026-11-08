Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=203.205.221.192
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794163555;
	b=ch5gBX8bWKjzX/Bq4QfaBIJqYFjoft6B1Jc1KN+TOvSepZs8eiFusWRUCzXAThXlFaBg
	 55iV+UYCZItiIhYGkGqSCUa0BMx0IfLkDNY8CTh0AbuvTkUJ4WACdKfegTARvUU+ajJ4i
	 x4PN38YXGpP8uo3psTukX/tCjbuejrCjqVb3JXjpeU51ypUf96J04YKKWOAYEI+20x6s5
	 ZdBchmiNSXkBHYQUqsjpQgIMepwNedVkfuGUNNd23GKmdvsUoF2kKnAKw4wkRCr2PjP/t
	 DkgScKFBrGZdMvZgAUgYvQHvSeXw5WA4ekZJdAwLWg6PFo3INl7O8vE+yHaoxI3MGvA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794163555;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=cocHiwEszqfOsP6pMfNs0Ig4EtP/W5nSTw5C5eTkuYY=;
	b=aS1lsb0kZcCLpKzaGbvbCFIuBVGDxjA5tUxKxR3CsQmfg0kIBABokTfqGNsyofmSBcLV
	 k5LogwbSXA5zk9REjyo8p6sjYm+XIPyVkNxr8aoi8Q9ihZ5W50SrDlZpmz6nRHd3hjES0
	 gqw7KNT6O0Rb+XEBqXR5Mg2PLlVG+mdbu129o8pPEaGSTuOnrJUgPlYpO+Uw7261s6rCr
	 /HNovDf6A2bhD73vPP8OSDM1O2ITUmhT6BeSglEexJpANL23FyY5TFWvfsr+jtP2Zowl9
	 tIeDHRcGAqMWxK72hPG2xDqw7qGLzFC+cWgASI06y7O6IY5fq9wIJ7K/dg+iFEeVhiA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=foxmail.com;
	spf=pass smtp.mailfrom=foxmail.com;
	dkim=pass header.d=foxmail.com header.i=@foxmail.com header.a=rsa-sha256 header.s=s201512 header.b=AHFcJtA+;
	arc=none smtp.remote-ip=203.205.221.192
Received: from out203-205-221-192.mail.qq.com (out203-205-221-192.mail.qq.com [203.205.221.192])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77540606A323
	for <netdev@vger.kernel.org>; Sun,  8 Nov 2026 18:45:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 77540606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.a=rsa-sha256 header.s=s201512 header.b=AHFcJtA+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1794163545;
	bh=cocHiwEszqfOsP6pMfNs0Ig4EtP/W5nSTw5C5eTkuYY=;
	h=From:To:Cc:Subject:Date;
	b=AHFcJtA+ALe4Dc8I3eEuyLEJ43gjzk7H16kRknTwvfk4tRPZ+8Nag1Tzrd5gLUnI+
	 D0nrnemOhcF+DW15eJ1met4jvqmwbktmfKp0xaUV1OQfdJKr+sKk3Ei+tVJBTvQkzN
	 2/JIGlvzF90LKgNTcW/VkpEO68wHvfghttTdSWfE=
Received: from localhost.localdomain ([183.23.108.92])
	by newxmesmtplogicsvrszc43-0.qq.com (NewEsmtp) with SMTP
	id B6A9EADA; Mon, 09 Nov 2026 02:45:42 +0800
X-QQ-mid: xmsmtpt1794163542t72ihwdqo
Message-ID: <tencent_ACC296C1F221C304053BD0F1F4B0D2C2BA06@qq.com>
X-QQ-XMAILINFO: MaaIYtAFx2QDKI5cGD/OiG4Qiqra4mBkJ4LA5d+ENbLaCVZ0iyTjs8ccWbtW3s
	 Gu9tj9Lim6y4K9du5rJpleP8Iv+uBdsSEjxoHX/ieT6fgOCe3LgLt/2yprR40mCR8WYSutP/xIyQ
	 nut364sSu6AakTMNMW45RoSm8WcLQSBlch6Q6Ge88f3U3KlQHfvUhOOPtoaLFmjOTagFIQ2pY0Ca
	 HEkQHFOnMxPuyU+C1p7FL3ie2KhhoeNn59GYFpENaVmt0FLxAgA20QSEPDxRUlNH6pSZDOtWKNdZ
	 AJ7YkcHPHMWaAf71aWAgmkvwtbCFBRMZYlTrNTTI3LgqbWW9EWhh0fV85YMzLRpBkPHECIwsduP5
	 QlSwbSJNsnfVpwfCTT+0tK+a2d/ZW4Mbttb3/y7wB+N3V5RpOpNA4sfLrNe4bfcVKjyRdp5204XQ
	 pkUfweem8tUjWyJjMXeuxmRKG3YkJn/oPtX6jzGkqSbqnA7Cetyyb/vWS/glz7qdoErNstd7lo5m
	 01A6VLATih7UuGeGtp/VKm3RvylqJlExcOYVA6Cr3kmcuGtR5JRVNigRQINpjcWJ5+bmaXgecTwG
	 rQmaJes6cVVg9jNfVdZYPcn03Wzc3pdfxnlwfsoAG9qf3WyfZRs17Zpep7tLgx347EWEUp5Ir2/Z
	 GFFNq5ZayPJFI4xPrW0GjG66zDQbxlPk0y64UU37NVaEm3Ay9bH0ZUFH+3RjS6KpaAJFOnyKAlCO
	 355TYBNJWJKN40NDV4MnxbbGX8hEIiW+Zju1Q5EYHvdc2XVu7C+QdB0Vl8gli/gnJ0tLpvvG71ph
	 mfKLYOyYtPZcKWD+1h0EdZBeSL1vjNIn0ewgY74ap2jqqWFlAk27MjEtfwwCdiAlSqyahi+urF34
	 P4fpCOwcb2G/0e6+KmTOsuPJL4R4iGgiuUpXr36VqAdzxcksy/AGgiKF5eA6vIPsOreDMuIP5LxT
	 mSh7HO22hleTYWsRQhnlCQ4M9DvuYA2AcoZwjqkb/YK9VkK+20PXtAssyGXWhklNE7jd6eyhyGHZ
	 TaeQe0Dza0qcedEsjdBy4UJftBJQegjTqegpgPEw==
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
From: memoriaru@foxmail.com
To: netdev@vger.kernel.org
Cc: Steen.Hegelund@microchip.com,
	daniel.machon@microchip.com,
	UNGLinuxDriver@microchip.com,
	79190669+memoriaru@users.noreply.github.com
Subject: [PATCH net 0/2] net: sparx5/lan969x: fix RX ring stall on frames from inactive ports
Date: Mon,  9 Nov 2026 02:45:39 +0800
X-OQ-MSGID: <20261108184541.74618-1-memoriaru@foxmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
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

From: Zhang Hewei <79190669+memoriaru@users.noreply.github.com>

The FDMA RX path on both sparx5 and its lan969x sibling stalls the RX
ring forever when the hardware delivers a frame whose source port does
not map to an active netdev.

In both drivers the RX NAPI loop only advances the software cursor
(fdma_db_advance/fdma_dcb_advance) after a frame has been successfully
delivered. When the source-port lookup fails:

  - sparx5 (sparx5_fdma_rx_get_frame()) logs an error, flushes the
    extraction FIFO and returns false without touching the cursor,
    leaving an skb_put()-extended skb behind in the rx->skb[][] array;
  - lan969x (lan969x_fdma_rx_get_frame()) recycles the page and returns
    NULL, which makes the poll loop break without touching the cursor.

Since the DCB still carries its hardware DONE bit, every subsequent
NAPI poll picks the same DCB again, takes the same inactive-port branch
and stops again: RX traffic on all ports stalls until the driver module
is reloaded. sparx5_xtr_flush() only drains the QS_XTR hardware FIFO
and does not clear the stall.

Patch 1 treats a bogus frame on sparx5 as consumed: free the skb, clear
the array slot and return true so the NAPI loop advances past the DB as
it does for any other received frame; the slot is refilled by the
dataptr callback when the DCB is recycled. Patch 2 splits the two NULL
meanings on lan969x (allocation failure, which keeps its retry-later
break, vs bogus frame) and advances past bogus frames in the poll loop.

Found by code inspection; the stall needs the hardware to emit a frame
with an invalid source port, which cannot be triggered without hardware.
Review from someone with access to sparx5/lan969x systems would be
appreciated.

Zhang Hewei (2):
  net: sparx5: fix RX ring stall on frames from inactive ports
  net: lan969x: fix RX ring stall on frames from inactive ports

 drivers/net/ethernet/microchip/sparx5/lan969x/lan969x_fdma.c | 18 ++++++++++++++--
 drivers/net/ethernet/microchip/sparx5/sparx5_fdma.c          |  9 ++++++++-
 2 files changed, 25 insertions(+), 2 deletions(-)

-- 
2.39.5 (Apple Git-154)

