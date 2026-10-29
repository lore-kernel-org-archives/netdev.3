Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793315902;
	b=ZwPITeDhVTjymTyHFIkFpg2k/j+Mb8g9BIqLH3aCkxy8Ct1slIDl4rNaXsnzOxsjUX1c
	 OYlL4WpRkSWAgem7YRF9qIfQAlyPwi/CXkOZC2jaVZqwEqWf3OzNdAUSmzmhMLW8prHdU
	 3rRis+ICPC4gq/Yc0KWzFzOMKz1TuyFxW02cYXYubS8twL5bekwApeXSoWD3+SzB486V7
	 rsOCbPNLFuPueEuPkitwEDmx5a5m1AOJhNEdb3cB2KSEPvuAhHrgRNO26SWrqQgFNi+sp
	 OkDOjO1oPNzadU1Y2z1zaAe0Ir21bbh5qFFf5tgg/aDtWyMzMKcwKPrMT1QdXUI24jw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793315902;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	bh=QztNW8xCZa3I237qi38L8jVCSovnxhoFmR6AqIN/+uE=;
	b=I/HpBhQUT5ErmepwHfyvk/qO8oKJ3RTjgCNtj21UB1vFYa+GtmUQjblkryDancqlZ3X+
	 bzYBmgRAeAPbwHa6DJtPzW84gWHBasAkzlAsp/fss2fQ9nGmsix46KqjRRpJ1zCR61Jxe
	 4K2VqXpsTB4mdDWsrtn3c1ld/Bp/+7U4kjEmSnlY5sP/uB2SNoTiTsCwISbhBxjXatNBT
	 fC+vcNyPDuPHWMYp1w1RwUimSeU8c7cFyWbnis745ez1Jd3BbMnfVwxdtCrUOxWvre+Z6
	 wzZfw5WOgSdoUdIC4lOPw+c4w36F3EnylPGoenI04Jsp2NP+WNXVD2KDT2ft8re8w3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pQfny9hg;
	arc=none smtp.remote-ip=209.85.222.53
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 448B1606A31C
	for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 23:18:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 448B1606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pQfny9hg
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-99061e2171cso33984241.2
        for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 16:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793315901; x=1793920701; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QztNW8xCZa3I237qi38L8jVCSovnxhoFmR6AqIN/+uE=;
        b=pQfny9hgOyIecqE7ON3oxvCMVGRRj6Ck9jcI8edPD9+mQZDHxwjCs7CWA3ldoi1VmV
         ZwYVZI3AOG4gulqAGuVu6rhdEZPQWqxY4ID14ggrhFJyveyoxlv+e6u3tR0KF1Owsimz
         i9ugaM61DCRuIMTYlAjJmkBKXd4KjVBVZmau7bRpYQBH0z2tOwGXKQ60V/ajkI4tMUqH
         opfdNwxd1IHhDqT3+dBg4GIvWsXX+LaatFS6B0Xc4SoVTFuFgS/trqICmwra2W4Vd97h
         JzwSF4gTGij/bVMU7VCOJf4VfX95nvOyNO3eHSs+Z4eB00w2CITP7Q8H1FT12T/D8S6G
         ZgNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793315901; x=1793920701;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QztNW8xCZa3I237qi38L8jVCSovnxhoFmR6AqIN/+uE=;
        b=e+M83hVr4dzDZzFr5ujB2bNIpL95leWfhgmGOlNxdcngl4j4viIhFDN6yfJftCV508
         XcvZfDmtK9XAAbfpWhcwhAj8YZ82NnskYt/KppzLkqUTv/ZmncqnNjFLWdFvf1ACVmee
         TqoftUZVP/rzWO5Ylf65qUvpZw4+p20ZQvKoRZT0DsjjEy+2gxlotHfjjkhYQJpGrgQ2
         dwhh0+5+QtXGyxGKrjKdx4t6E7NkTUcSFTCmEhtvizFTx+y9p1hjcDGCq/YmzrltWMbV
         ZQSvEMVAeKxuGc6wa03uCfk8rPgd4DUG+s6V8dICklaO3lTYd3a77A7z7jw0GKE98Aag
         4YYA==
X-Forwarded-Encrypted: i=1; AKwUvBx7gNa+lZnv7TZuG+pT4oikDkAn4EJEWBuZrmC4fOISQsx8GM8Tcr7VC5ijAPfSGhBXqqb7WC0=@vger.kernel.org
X-Gm-Message-State: AFq9FYISllyuaEf0e0NyKHUum17q5j9vjZpBcboaSbEQly9H0W6g90dW
	2mMuhc4MbZjhg1bhkoUZnjm/72+Ie1S2qoB50d7Y8oHDIUTAapJ2Rx2W
X-Gm-Gg: AYBFou0jnBy78sibWdAi1UDW/7JChnBzwgp3RSKykGCYvyrDbUQ7I3Cnkhce41vDlTd
	pooBfpZEmm9JX0KKuG/VBiLRFlKd7AMV6zIA0tXnNkqDMdIffjBVrlMSqnsiE8iqeSX0JXrE3xS
	5awrWRKflb60fnNUmlcoANXKH36Vsi173DjehjPAj34J6MojvomDZ5nVRBlWUflR8DlwNwtE1zf
	rrtW5WFBZ1Gz8xmQ3yzdcPwS/wmdelaS1wsUPM6+edobx4m8WG6A3MLCCRgIpfvkXro74xRgqUp
	HvX2zREmoKDsE1cXJ+4UYmk0AAcZdVYGyQ0rtyH2ElIh37Dy22W5qyrUmZel4tnm3mz2uoM8d18
	H5Z0RxlRSL06MrokLEhIzFbQexc0XC5ivDazF5K4h4p+zpLoExK6V2BW3G7eqEfMXltkBhP9kcl
	B94uksZ5jvCoIWEodKuFvn4o1mh57pL7Sf7ulPOCDYt9R9al8fWQ+OBpiIJwuWZBt6oKV8Mi+TB
	rANotb8Xrv0Lw5to30gIa9v4v3/dXl+W/ebB1GHYSyM53rx1lNMRIb7fJXI8kftiEF92cL9COnr
	wmmynXKHFZdoI8tXnYPtTX8yKVo4RZP0Pfh/d2W5ON388Tjly5aEJTZFyvUVHc/zgbGtTkufRxu
	U3oOf9hjW2F9n40uNPlLBvzSMi1964GIXmQ==
X-Received: by 2002:a05:6102:8099:b0:7c3:472d:be6b with SMTP id ada2fe7eead31-7d072d376admr338758137.33.1793315901228;
        Thu, 29 Oct 2026 16:18:21 -0700 (PDT)
Received: from [192.168.15.16] ([2804:1b3:a2c1:77a1:5cd:8fee:f3c:4da7])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-992ee4e7453sm319509241.11.2026.10.29.16.18.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 16:18:20 -0700 (PDT)
From: Joas Antonio dos Santos <joasantonio108@gmail.com>
To: David Heidelberg <david@ixit.cz>
Cc: David S. Miller <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Zhenghang Xiao <kipreyyy@gmail.com>,
 Sanghyun Park <sanghyun.park.cnu@gmail.com>, oe-linux-nfc@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject:
 [PATCH net 5/5] nfc: st-nci: validate pipe ids in st_nci_hci_load_session()
Date: Thu, 29 Oct 2026 20:17:35 -0300
Message-ID: <179331585573.30322.9370333985353215726@gmail.com>
In-Reply-To: <179331585573.30322.4049957541187612575@gmail.com>
References: <179331585573.30322.4049957541187612575@gmail.com>
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

st_nci_hci_load_session() gets the list of open pipes from the
controller and, for each pipe id in it, asks for the pipe information
and records it in ndev->hci_dev->pipes[].  The pipe id is a byte from
the controller and is used as an index into pipes[], which has
NCI_HCI_MAX_PIPES (128) entries, without any check.  For a pipe id of
128 or more that the controller reports as open on one of the known
gates, the gate id and the controller supplied host id are written past
the end of the array, into gate2pipe[].

The pipe information response is not length checked either, so a
short response is read past its end.

Skip pipe ids that do not fit in pipes[] and responses that are
shorter than struct st_nci_pipe_info.

This was pointed out as a pre-existing issue by the sashiko review of an
nfc_hci_create_pipe() fix.

Link: https://lore.kernel.org/all/178952042575.22033.9676833200303972344@kernel.org/
Fixes: 8ae01f796771 ("NFC: st21nfcb: Add support for secure element")
Cc: stable@vger.kernel.org
Signed-off-by: Joas Antonio dos Santos <joasantonio108@gmail.com>
Assisted-by: Yaga Agent HackerSec Claude:claude-opus-5-5
---
 drivers/nfc/st-nci/se.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/nfc/st-nci/se.c b/drivers/nfc/st-nci/se.c
index 607ec768e..909fb1493 100644
--- a/drivers/nfc/st-nci/se.c
+++ b/drivers/nfc/st-nci/se.c
@@ -191,6 +191,9 @@ int st_nci_hci_load_session(struct nci_dev *ndev)
 	/* Complete the existing gate_pipe table */
 	for (i = 0; i < skb_pipe_list->len; i++) {
 		pipe_info[2] = skb_pipe_list->data[i];
+		if (pipe_info[2] >= NCI_HCI_MAX_PIPES)
+			continue;
+
 		r = nci_hci_send_cmd(ndev, ST_NCI_DEVICE_MGNT_GATE,
 					ST_NCI_DM_GETINFO, pipe_info,
 					sizeof(pipe_info), &skb_pipe_info);
@@ -198,6 +201,11 @@ int st_nci_hci_load_session(struct nci_dev *ndev)
 		if (r)
 			continue;
 
+		if (skb_pipe_info->len < sizeof(*dm_pipe_info)) {
+			kfree_skb(skb_pipe_info);
+			continue;
+		}
+
 		/*
 		 * Match pipe ID and gate ID
 		 * Output format from ST21NFC_DM_GETINFO is:
-- 
2.43.0

