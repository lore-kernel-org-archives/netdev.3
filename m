Received: from mail-wr2-f0.google.com (mail-wr2-f0.google.com [74.125.225.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E043A3F5BFA
	for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 18:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785176347; cv=none; b=UVPLg0V8ff+RtYoDP4lgfNTpOy82AvfU4FGMCHWiHMhwqWyYo8RLt33O+S1wvo5t70fWpbW88SYDoQoYLJHMjfu+MBnTyjiVql5jAWuTT8ZQLWL2vPQ0NiNeCQQMLWOOvu8VWKOp1ucQR0eWaytuZ6yITyhu5DtqwMShzoAA4sM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785176347; c=relaxed/simple;
	bh=ESRiHzT+ED7aWVrQ5AX0WxEX4SZ/8pS7yfOrbTYRv5A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nNi+62d5net0W6YCvBixLQ/IAAFyUu+QNhcs79xH5Bf6zA1PPfhc8IAm9jZ46xUgnuiPfI0YDGC0wKIzyUgZ5jaxxCFALCnCwUT2N3TkwMH2EbSPChvD84DYIkxdOh58bFcYpjy1JFdEkbCvJvPbTFD+ZZ+18+8xfureuNVu5rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.225.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr2-f0.google.com with SMTP id ffacd0b85a97d-47f8fd5f16aso1409779f8f.0
        for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 11:19:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785176344; x=1785781144;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aZtPOmEfzBDC6oqY7JFUtrjEXlY1gNUwwzp7G9d1bt0=;
        b=e3nvfQDWOHxzgtb5tHv6O1VEbCSUix2iJ9njktaDjgEzX4Mv0UBLdPUQU/baT2teNT
         oiQOpMX+dHWrxe90mErYVd/l+FjopB5H7BnAIU2cNa4ijEJ/bdGBdmleEljlvCPk8tf2
         8hJJ1KN/Rgh4P1rmrwmmLHNKf+pdJcUJ9UaoFLOL4NL9lV9v/E9enCAF6ZM4o5hP5qur
         XHAszXoELOFoXtyqpYFgEAaakLnovT3zx/fVtYibyxBNX4Qnh6lQppx1X9NsG2dI21YT
         cPQ8nzeIdeVr6JqRYSYttPRrX6awdQNxRg7aDBZPHxn5+opKlhF2r42osvTy8C5uwBJK
         E0Kg==
X-Gm-Message-State: AOJu0YzSopcRx6GfuqMatC+Uer/EX3efTSogI19DHIYhIPWahKrLSGGn
	FLxFRoBc3IJTaqEcIZeZoQzQFGvqoZ0Is/bhtF1w+ZqWIfNN5UxnmH/QBJjfpl6l
X-Gm-Gg: AR+sD11lt58V+YjBoDFQUStz/gZmyXlhLc1MNPXMF+CEBjbPA6NnxO3n/jQuhW3fwn4
	68lLf3ONpq58ZVyHR3cCadHuT26Wa88GjVvNx6IHC6yWAbK/IPfxjuPY9NFuEWj6pb8SQpxfUJL
	m/yOhMxX6HoRqLGcB/2dxJoLleM0OjzfAEi6qmBGLO8KmQBPMCKlRPh4M32QCzu80PMqzMuLKBd
	lBGMjzd2x//Bpb1OZ/9EQRU48KiQG+uUEQjqH/1UCjqUG13J4u5P6hF0xDBTmJfdrh17T9ZqpuS
	COZaQf1LYHkjqC4RrUDRQSD9DAbL7MipgcM6kVtCwVQeLVM2g4UiuqVsRZOIeyMvSpRdLn3Yxhc
	syXU9aJO2p0laH0X0wOhZl/bScTDHae4qEOZ8dyEas3a0bLHH+srt5dSutD6vSpPZlDMrGVL9I+
	Kciw1oP/AVLdC0YBNL4gCgu/5FvDSGFy4KuzGGV7g2XD40R5y4lfc3fw==
X-Received: by 2002:a05:6000:2dc4:b0:47f:8273:266c with SMTP id ffacd0b85a97d-47fafa80c05mr273673f8f.56.1785176343930;
        Mon, 27 Jul 2026 11:19:03 -0700 (PDT)
Received: from im-t490s.redhat.com (78-80-108-129.customers.tmcz.cz. [78.80.108.129])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85c52fc0sm51042855f8f.23.2026.07.27.11.19.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 11:19:03 -0700 (PDT)
From: Ilya Maximets <i.maximets@ovn.org>
To: netdev@vger.kernel.org
Cc: Aaron Conole <aconole@redhat.com>,
	Eelco Chaudron <echaudro@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	dev@openvswitch.org,
	linux-kernel@vger.kernel.org,
	Ilya Maximets <i.maximets@ovn.org>
Subject: [PATCH net 0/2] net: openvswitch: fix skb leak on flow key update failure
Date: Mon, 27 Jul 2026 20:18:29 +0200
Message-ID: <20260727181851.306076-1-i.maximets@ovn.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixes for two issues reported by Sashiko while reviewing other patches.
The root cause is the same, fixes and the Fixes are slightly different,
so two separate patches.

Ilya Maximets (2):
  net: openvswitch: fix skb leak on flow key update failure during
    recirculation
  net: openvswitch: fix skb leak on flow key update failure during ct

 net/openvswitch/actions.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

-- 
2.55.0

