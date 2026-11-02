Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793645485;
	b=Mw4aXE6u6J/RDIfaY9Pb69qU83y8TsIm18hLajK/3HKQsULGaC1qrARelVTp9rSAAaLf
	 V9QjFnNQbKfNfpCg616twNS0NMPwUp5dSa43a8sSnt+TrOPA5KC3vW7zsbbiRfFkhHCPS
	 Z4Rd2PpMJJ9GSzvN/nCDrBtnopuN6a1TO1Kf1n0lISKr0BDTACRbeFM6S4E4Z/LJLKsG5
	 HLs5790rEDWbe9lMhyjp1s/u4Xl0Jm+XZyiALmPUPXxkq+iOnup9g+JRPyY2/T9s6TNvp
	 KezyPn7sp7Bjh3tShLvXpIuR759PcROuP2Wu7wApjq8OEQxIQaJrDany8ibRawfopBw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793645485;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=QlHiGf+lt6/lLFvfcn5PBs13x1On6n09Gjxo1myFIdk=;
	b=NCvFlu0wt0FPBelzFsMvZRtmrJ7CUpov6M9VXI3TQgIj/0jFYWj6OUmhTZM9ZdX6K9e2
	 hNc/M02cpaZeKWV7IPkz9pVxi+QhhFp/SU29pKnmGp6Bzu/5hTaGFsOhLruC1ThNaB0IS
	 yBmIu8KM4wYjqOPzxuhhjD8KTkfqBARYuF2GmKMilK617gYbZqVrrUppd4+lQrpAZDuBL
	 Ad2JQzoz8iuN/vc2Q2K+NvTFIM2pwq0QAe89H0dv68zk5DJLx0pCCucRiosx0hYIaMaOx
	 pdxE44VQbMOST3HocqldTAuIxeSVDwNOadA2UnUV78Mw/lBfH+BWG7nZQlvePNRzyoA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vBrS4SZD;
	arc=none smtp.remote-ip=74.125.82.52
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18CDD606A324
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 18:51:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 18CDD606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vBrS4SZD
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-1438d9363fbso2642195c88.0
        for <netdev@vger.kernel.org>; Mon, 02 Nov 2026 10:51:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793645484; x=1794250284; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=QlHiGf+lt6/lLFvfcn5PBs13x1On6n09Gjxo1myFIdk=;
        b=vBrS4SZDzaYDB61VTJynnuJZcypDpcykiaFHOWQX55fGMHia+iQJWyVnZlQmIwpU4C
         nBuC+w6bspHmULaJL8SBFdimZcfxZpuDZ+wWbazP/O28WShasGACIYvZrx0KzOcVo5Eh
         uwjQhSUbtQmD2AY2s670mh/DNVOTkKKu5GZ2f/aVD888fJj4dxsYuWtL6aj1VPqNJDJh
         PXpxqQNkp+uTsFQfsalVmshJ0zH4X8nt41cCVTa92pR84SyEdvzYwGrtB2oGF4ZHVQX+
         aFhxkavq6Uen/nOV9p46cNH0fDLbV1WUWGg8cSPV0VgqalzxkG0wdalugMZhfGPQkRo+
         RFXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793645484; x=1794250284;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QlHiGf+lt6/lLFvfcn5PBs13x1On6n09Gjxo1myFIdk=;
        b=rZskfFlEBcbRfCgjAwdszYLgmzk/sWl8wJ2JRO5c7q6Z2gebltilpgNwNH8x5K8YsV
         DhdY7STl49OLtlA9z2ZhlP/k+AqXxsG1W2L/wvSnYZYhqNLAUXnp6znicA1SzEBBuNyG
         imJbDhaeuWKHPXCuxBPyntgmMLGtcZy+98Nlu+E8vI+Gt3ZDEqZlsdCGvEIhS8TwL1Rm
         CvrWSTERz0PWSng+lyzHTGjXQnkq6Szh0DlNN7Asjor+mttFJVu6z8P6seM3IgEgRQFy
         wfxGWvL120JgtlID1gXr1R9rASBQW19l+w3WpCGWDAvhl/ESd62uTT5BsUw+WkRB2sOi
         mNUA==
X-Forwarded-Encrypted: i=1; AKwUvBxL4Vz5hpug0AjM68JjN0bp4PJNy24YUU935IwAJHF6J9On0uwD8LCTPhuwLYSTeJmfFqyXdBY=@vger.kernel.org
X-Gm-Message-State: AFq9FYKPmAdbc4cbhjFYwzfCeQ7KDKSfkpsWP1hedxZy6pns8w1Q/PQN
	RWtuSJw+YrFtR+S+xz8pxCJq9JN9bVvr6sWFOflRH1Jg+DDGeI7a0R03
X-Gm-Gg: AYBFou2Ihwg5cKeccLZGBQD9JLf/Az5dceQibX/xS4JJ+F2MZ3gXqnfAJK38ksAqxBR
	94UMc23B+n2rhy9bTkJmyyZMQenOTLt2MXeaH4w083WhMBSyegUs0/NChIZZjIsWCDzd4wBWZ8c
	oJIJuRsID+p8zgG0xFa+5wf9mHNKAS9H2aN78aeAkO2gDoVuPi1UEBqpEAwv5bxBNPOIpUFxsnx
	R3rE9dk9lVOP5tfFEQakTpDRFPCvYkFN+LJF9orUHCxapoH8nCGYNiR6ZwbQtM6pVBsPnyPbKti
	+2PGf1NwBm7k/3qB1WHfuqUiTBH8m9TeReUTcVisDTYN3ulfE76mESsPw7TFKSo7EeY2I1TZUnF
	cDddvjB67FHhXZwNKp7L51fHSJqCqISFRxXHA4nEhw3q0QyLUJ5CovkT1vgX3H0VbwtjWOkmD5O
	NaiCDcwonmivwFF3eM9JWc8evxmANQfVVftxnfkx4SGLb6VEO/wFJN5gtnZ8RydNI+5karrZDfH
	k0UQMj1t1O2WHvIuIDoOVUzVc78Fl0VEP9iGiDPv6HIaFZPb+OlED4Ap/oGZs1I5RnkZdYkXjXO
	xjwxSFBGwZZqLfXUlQLdaq+nP8D8iiUx1Jis3lAmF/CvGu4RcUJwrFJ5whaMiUiTp2p/xQLrWyh
	kHhxOfw8YCNSVuLpox306gASWIwo+uZJxuU42Zbtq6GLmdw==
X-Received: by 2002:a05:7022:628d:b0:184:40db:6bb9 with SMTP id a92af1059eb24-1a94876dbd0mr27132117c88.8.1793645484075;
        Mon, 02 Nov 2026 10:51:24 -0800 (PST)
Received: from l ([2603:8002:ea00:6800:4808:7aa2:ac97:30e9])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1ac1abcd6f1sm34625198c88.20.2026.11.02.10.51.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 10:51:23 -0800 (PST)
From: Dave Seddon <dave.seddon.ca@gmail.com>
To: Michal Kubecek <mkubecek@suse.cz>,
	netdev@vger.kernel.org
Cc: Dave Seddon <dave.seddon.ca@gmail.com>,
	Taehee Yoo <ap420073@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>
Subject: [PATCH ethtool v2 0/2] netlink: require a value for hds-thresh and the TDR parameters
Date: Mon,  2 Nov 2026 10:51:19 -0800
Message-ID: <20261102185122.1357927-1-dave.seddon.ca@gmail.com>
X-Mailer: git-send-email 2.56.0
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

hds-thresh (-G) and first, last, step and pair (--cable-test-tdr) take
a value but leave min_argc at 0, so a missing value prints
"invalid value '(null)'" instead of "no value for parameter". Each
patch sets min_argc to 1 for one command.

Changes in v2:
- Split into one patch per command, each with its own Fixes tag
  (Andrew Lunn).
- v1: https://lore.kernel.org/netdev/20261102023919.1472495-1-dave.seddon.ca@gmail.com/

Checked by hand on a build of each patch on bae2dbd: the parameters
it covers print "no value for parameter", the others are unchanged.
make check passes.

Claude found the issue while porting the code from C to Go, and drafted
the patches; I reviewed them and take responsibility for them.

Dave Seddon (2):
  netlink: rings: require a value for hds-thresh
  netlink: cable_test: require a value for the TDR parameters

 netlink/cable_test.c | 4 ++++
 netlink/rings.c      | 2 +-
 2 files changed, 5 insertions(+), 1 deletion(-)

-- 
2.56.0

