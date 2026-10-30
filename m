Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793358652;
	b=T8YhXy1+FrDOa3aJdO2x0lQtILIS4jvxG5kDb/8RiUP9umpYoEJ8nKQoob9/N6NuL2II
	 jlB6+gZduK0H+3dEGdkNo4qHs5up+y8kl1bHewTGsylQFKrO7AmQlxowlNnZYJSygLaRq
	 wJunM2mjZkLiEWf5T+yfPPTKhfQl20e+zfwj4FmHyYjzvAMXJEL7uDQWLdl3MZiNxCm0v
	 b2k22RVfH43WVrPtKFUtz/T8jQTWsHLT0/3nwlI75YKL82IixXx5GNTw87PuoZxAp9hx+
	 OWZVlnVk8/5aI6aGa0iwD+PQ9wDQuld3Ki7i7pPt5Cxy50z2gM+tZzZQfXUH9j9jpyQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793358652;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=3K77XNkfMH7a8onwpIoaohwCSVh2S30EXP1W1PCwgg8=;
	b=nitnK7fQAbJClDTpe/T5ySRTFBUKmzB38pBiejkYEdJ+2IRuIxHfbkQvBUtZJnsLz56y
	 kIZXj3Jee0epE8EI00SfBhMYxIU/QudAjMFS2V8u0Oay6H5zpzQ4IL8Fm6iRmq9JyUqR1
	 NF6BEUS9qFOFVkdpptEhqqAJ1LaK9o/K0e9ApaidFbC86k27fBdWCJDDf6rreLPwC7NJk
	 A7vGzvpymUJBG4v1NbFPtTPjfGZ0e+KxBScBYslarP4aaXlCxQrVAM9d6o0EUUv2a59ZW
	 fH0qDcES3R61DENh+yo7/NlMg2Qd4e+ve/gr/S1ODoX2tQN0tzjVLYy/PpIe5ZYu7dg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Op+K9gir;
	arc=none smtp.remote-ip=209.85.221.169
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 292CB606A31D
	for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 11:10:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 292CB606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Op+K9gir
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-5eafb65e204so186509e0c.1
        for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 04:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793358651; x=1793963451; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:content-type:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3K77XNkfMH7a8onwpIoaohwCSVh2S30EXP1W1PCwgg8=;
        b=Op+K9girD6S4wCdakdfLsogm7mwuSirVskruFOu89qb11mi+oFCrsYh32/RHot1jvF
         5gSOe3BcwsMBh4MoCZD2X+LktUSxwDY6mH3vlDr47d8RoVpGenvO47qxJPab6m5AS0vV
         InGmUtmB15fUSz2hZxBOKURp2LWvp++46FsRAXyzxhZu9ehgLUlsrnX4rlEUNZ5e0VP7
         ZgmbHkZID5oS7e2gvnzl8TBNR+ec+nKREpgJJVhU4ZyqPgSrsxDrh1jcFinhgquAvnU5
         RMObtQlUxJ6p86d3HymhL/2lgDY+/WvtMZK9jaN2kZM4HY7UZIDI5OQdmkLFg84D83no
         4Mvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793358651; x=1793963451;
        h=mime-version:content-transfer-encoding:content-type:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3K77XNkfMH7a8onwpIoaohwCSVh2S30EXP1W1PCwgg8=;
        b=YYHsOJ88Y5DI5zdF2x3iyZZn5DvvJNZLZo8XSXGa01z70AyqHX+CGHpXjvL7IliKE2
         GYy4d7iSD2aRvoZ23p9kSxqIXcigap5Sdguw0UxPd/ewUfwxC98lMCWWtd8eQdt+/tTS
         X375rHNEUxWj8P/NcWklmVFtfpCa3b2HREJ6mJYNBZVksPhCU0mhIrFOG92U7kWXTTLM
         eBuVXWbsU4NOl+j0VN9E299uQ233RoUnYwwGhaj+8MsuGbscNC21XnSnzs1RRgKCSl51
         uHA/bMx4flF4xTa8cCNCeC/hQf0BGkrEgXWQidrczNflk/R91FnEeIdBSiyg0RQY1mvd
         tFhQ==
X-Forwarded-Encrypted: i=1; AKwUvBxkprbxdwbkmyY5svKLQRj49yFXkqyhiICgcaRMEgs1F3C4LmMnn8GY7hWL9qlXL8qlaZ6KL/4=@vger.kernel.org
X-Gm-Message-State: AFq9FYLDBuVRx7cgbUM3H1p2Pth2YKk2DBEp4VZMU+92bSYfDLkr0rHc
	SxlX6zEaDzYEXVgiQk7RHah63T++O3h1RxpwnqU6hzzbjVcyPSaBs5Q2s230flsE
X-Gm-Gg: AYBFou35p8pwjADKMBqSlEgoRKeKk6+a2IEgfgEqn1Qq6qCHZ/0tbAFxSWr1NgVIKAv
	hXr1E0Rz0aZME/9vajHqTbAvkT+36oXFMDzgswkEpkdM/ee+96VhkOpN/nKr7d24ACeSH79+be1
	7P0jWEoftxMCowA8G+9cgEbubNEzp+JKcwfb+p7Gud08QZo+pKNKL1+THiQov915EXtfeXamtR5
	WNwLaLcB1RHPgrWPHKkr3am8HDaY93rEoQpvbV6qZj0LHIF8sTG3fw5UNllFnmIf88k5/WyN+Of
	JgJZiGl52SJ2rXtjlnBv1ubozDPepZQWrAoqctigIU/9gbadIHZNdCe99dixxRK/ckFCu0xU/Sa
	ZROOg0Cdg2nSG9LBDAl+g5q2cMLKBISnMPU0HJ3+2sPw0n/NU5ONmHG++ZMDJCDYg7pGeE6f65k
	/IJlyTl2201YJhVnRKUFZ+lv1GSAsVZYH6ck0OHKeQ6TrJ81eW/mEAAka4rUW//ePGp9SvVU7m4
	8XaD+YLk9djgIdc1Ekq+KGqS7MSXU6HbiZysb2in8WgOEt6r3ovLw3mOh2D9v2QUhJQ3phLmZxi
	7XK/hj6jcsXKdb5TkGEGOl0aI9RNuAFbIqeh9E6AtWPW06So2mdW0y94Hvqz2DCn8mALo3JJPig
	wM+7PPWbryAjDFQuU1cs=
X-Received: by 2002:a05:6102:3590:b0:7cc:2152:4f79 with SMTP id ada2fe7eead31-7d072c1571dmr826528137.16.1793358650948;
        Fri, 30 Oct 2026 04:10:50 -0700 (PDT)
Received: from 1.0.0.127.in-addr.arpa ([191.34.116.20])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d07754c1b4sm1841044137.4.2026.10.30.04.10.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 04:10:50 -0700 (PDT)
From: Joas Antonio dos Santos <joasantonio108@gmail.com>
To: David Heidelberg <david@ixit.cz>
Cc: David S. Miller <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, oe-linux-nfc@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net 0/3] nfc: fix skb leaks in LLC nop and in data exchange
 error paths
Date: Fri, 30 Oct 2026 08:10:42 -0300
Message-ID: <179335864271.64596.805818095553030218@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Three skb leaks in the NFC core, found by LLM-assisted code review while
auditing the HCI drivers that need real hardware.

Patch 1: with the LLC "nop" engine (used by the MEI attached pn544 and
microread) every frame sent to the controller is leaked.  Confirmed with
a test-only module that registers st21nfca with LLC nop on a virtual
phy and a userspace controller emulator: 20 device up/down cycles leak
598 skbuff_head_cache objects without the patch and none with it.

Patches 2 and 3: the HCI core and the HCI drivers (pn544, st21nfca,
microread) hand the response skb to the data exchange callback together
with an error when the controller reports a failed exchange, and NCI
does the same for a frame interface status error, but the raw socket
and LLCP callbacks only free the skb on success.  These two are compile
tested only (W=1); the leak follows from the code: __nfc_hci_cmd_completion()
gives the skb to the callback and never frees it itself, and
nci_add_rx_data_frag() passes it on with the error.


Joas Antonio dos Santos (3):
  nfc: hci: free the skb sent through LLC nop
  nfc: rawsock: free the response skb when the data exchange fails
  nfc: llcp: free the response skb when the data exchange fails

 net/nfc/hci/llc_nop.c | 11 ++++++++++-
 net/nfc/llcp_core.c   |  2 ++
 net/nfc/rawsock.c     |  4 ++--
 3 files changed, 14 insertions(+), 3 deletions(-)

-- 
2.43.0

