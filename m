Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.139.74
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793468761;
	b=e6xSaXbYmTDBs2/LRbtU+tdfPC67UiQi+eEiUyH4tD3lSiBfbYJJNtUR3+C5mM2e66ZX
	 c/EsJ/znRHdRATv9xu4yTk4ugSyo88bG+oGamrFCKiPDE0/qblR2cnPlVWtaA6qbaCxP+
	 ixr6McNP7r7nmcHDYUG4mQZtMbglZyxXpw3yRVrmrHq1VvDFWg8SnbCA1w5i4ZCtWqzot
	 Ep5DkFwXx3hLVyKhULnWm+GDKWIm0RSe6BGeiv2tDU984dY9AbgWYB6gLvkZPd6s7urkZ
	 vHZ82uTlspdBqQutRusDS4rFzKVRA7MzfL/bQD2sc97HKHc83SBRBoUv9w0PRGRF2mw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793468761;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:
	 Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=12TO2e0T31cSdEte/htfI+5i3smqp4TVqWraSxvTy3w=;
	b=rcLq8NwQdjUoKOlF7ZEV+NphqkUnft45bd00fxBx2nYTKW5kZ0GzBmzVb1N6yqG2oW4v
	 xxrjJkl1EB4aD3IwvvVoEEgvxK257RdQ1UUmpdyFahUWT7TKg1opK5wtg07G26MkNj/ak
	 YEBJuiWd9RlxvL5LbtB8psY8+J+/q84Vl1aevrdkqV/mOVUEPEtrv/Z3GUF0CCdGQhl1H
	 aKp71qw6rwFPH0b63W31ysokwx1nNHadU8ivYkOQ3NGX2ie9ksTMZrjN6GZDTrAKRqGf4
	 FOGGBs+CzjiVgIlk+IRxNmtFoIsewyWJkfxcGMvu6tpDSpnDPPaGujcvusF1p9MJM/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=columbia.edu;
	spf=pass smtp.mailfrom=columbia.edu;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=jrv2nOZ1;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b="neP/A2aO";
	arc=none smtp.remote-ip=148.163.139.74
Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABB6C60A260C
	for <netdev@vger.kernel.org>; Sat, 31 Oct 2026 17:45:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ABB6C60A260C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=jrv2nOZ1;
	dkim=pass (2048-bit key, unprotected) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=neP/A2aO
Received: from pps.filterd (m0167074.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69VDkro1559732
	for <netdev@vger.kernel.org>; Sat, 31 Oct 2026 13:45:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pps01; bh=12TO2e0T31cSdEte/htfI+5i3s
	mqp4TVqWraSxvTy3w=; b=jrv2nOZ1hp7gZbhO1vM3/PcfFfO2Eo+JrSCQRcC1ob
	JZIOAFdqM7Cv70L7PuIETHnhd9trPMvIE4Vhr5Ze645lh6+3Z3Yyu4d6HgjnPR+W
	LnQeSKOap9tnbXCFr2Yu+24s9nG4SHxLCy42p6uCdErv6i+HSk+zX7/YTMo7Mmyo
	X56d+LUijffqg2f4G3pQC6yxJs/PWK5DGOYbNI1t2gXcFbRO6bSo1OdlXPsvhW1J
	dRz2RdOGf5rWwSJFVdPkSwT6YDcnZiNKaiOWQrdff+vERJPAujUGw0u8QERN1//v
	tFTTHhwz6oVCE1EidtJ61Jgic9T/tAcuIp2psuzp8EXA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4hn9ccatsp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Sat, 31 Oct 2026 13:45:54 -0400 (EDT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-93f33438950so341335085a.1
        for <netdev@vger.kernel.org>; Sat, 31 Oct 2026 10:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1793468754; x=1794073554; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=12TO2e0T31cSdEte/htfI+5i3smqp4TVqWraSxvTy3w=;
        b=neP/A2aOSquMz2IRM3GwjWt3KSLmQ+sHBLc0gTN024tS1j2Ga1TlfzM0rbhUpalhBb
         MaMW0UySxvH6gCKTLWrXP1KvoUMJMyxZq6Kh87F6QViiC8q1HcJrGWj491QxL2ztzQid
         xYUcuWjDr6H5ykt/DYN3+8zpB3VcZ9uhk/KMyB3bH58mz9r3g4a7L1if8mbhw1ERRZs7
         29JUjpUrRNh9L/MmkOIbrleXFGUhDt5/NDUouq/1mRCJcYqL+EtlH0zqjLJ1UYSvL76p
         UM3mdFlMF1wfPmxDpHYtD3dXpRphcm0GeIwJ1geGp1JFt/9ftzdUPzhDxbSemzHyklBe
         PK+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793468754; x=1794073554;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=12TO2e0T31cSdEte/htfI+5i3smqp4TVqWraSxvTy3w=;
        b=lC8akOCg/7gz7UF/JxCrdcgJbxfBGk9UfYRBvJcjBlxIfJhNfZQPaX04X0CprtnQ6B
         +AHywlBIFNzpQY14AxJRMouQqbapDOGepFgm5wckwZMR8OVMjsLpjALZRuKDDDLIRNkW
         cmp3TDuHxQIbhiDXsgvkbA6EIppt4aWDFv9JSnwOev8ZQv89ExnMQMu2rL/pE7V4SPW2
         rBq2JAtg5ukWoWvIMNDj5mol8/kBRG3J4KAsxvNU1n1WgnS7GYi8H8nwp8DJHL9GwVKu
         OEdQ92ccC4sbkb28RM56BfZbh8tJerL/chOxR4l/unzlXSTJGYSj4Q8ecFMzTntQJVsj
         HOkg==
X-Forwarded-Encrypted: i=1; AKwUvBzbYo60nTK74xC7FFdHDiSdDB4d24m3vje7dm1YbT9bKZx6l0YBcSPLGeIlxpEA43NS2LQFMQA=@vger.kernel.org
X-Gm-Message-State: AFq9FYIYeYNkmpJb4pV7lz9l2OQ4goaoClJ5ldVazOM8vMWoDJJ5c44K
	pgVCKusX0fwqR6JCrA1aKvrXg5aF0sVO40xnY0jQhwMbjIqIH5oyd9Ehqdk6ZPriYX12GerrDfe
	0iYqv3ZpqxyIfMj6N5+Q0u2qjaDGpedjkEcjJhgkFdoITauTBaS4RTg==
X-Gm-Gg: AYBFou3ZMhQQ/j42hx0LDhGwID2fgWFTiO77UCtCkPgTtzbpbDzpQItSVlspD/fa9H8
	a2ELxAsBho09XiUe+2hOtjUJpmYnH5fwTtdVo0H2lhcTVRo7DsAp6n2UX3SV4ZKdt3KDE3RyEcb
	HW7zpn37iHKdrTal47QXgjTi+LPkzZylNplfKe1ynqCzHiH6kBgU/H2pwtFQRRV8p9IcMdiR6qC
	LyjekPnGRVXWJ7O3rPTMB3FfaodlgH85VStr/8vhGsxkDdEmXmI9eTuChlBXHVQjV1FeXClNoW+
	kFuAHjkGT+lQqVkRcK7NvOujv8yOTixlMVboT8+P5BaCzlPc8W2ut9ptyJxJL3+Ts82iMlHa0Jy
	OYBNGIBdiONA8BJk3ynqNGlVEOqoaIoxMOiu1/LDAromVelmE62H6L4gbRw==
X-Received: by 2002:a05:620a:270b:b0:93f:565f:e40 with SMTP id af79cd13be357-944217dc91fmr882364985a.65.1793468753911;
        Sat, 31 Oct 2026 10:45:53 -0700 (PDT)
X-Received: by 2002:a05:620a:270b:b0:93f:565f:e40 with SMTP id af79cd13be357-944217dc91fmr882361285a.65.1793468753266;
        Sat, 31 Oct 2026 10:45:53 -0700 (PDT)
Received: from [127.0.1.1] ([37.142.159.89])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71b79059sm10220667f8f.30.2026.10.31.10.45.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 10:45:52 -0700 (PDT)
From: Tal Zussman <tz2294@columbia.edu>
Subject: [PATCH 0/2] vhost-vdpa: fix a pin leak and unpin mappings by range
Date: Sat, 31 Oct 2026 13:45:33 -0400
Message-Id: <20261031-vhost-vdpa-unpin-v1-0-94ffc9683256@columbia.edu>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAD0p5moC/yXMTQ5AMBBA4avIrE3SSvxeRSyKwVhU06GRiLsrl
 t/ivQuEPJNAk1zgKbDwZiN0msCwGDsT8hgNmcoKrXSOYdlkxzA6g4d1bLGoiMoqN0rXBmLmPE1
 8fsu2+y1Hv9Kwvx+47wdX36AmdAAAAA==
X-Change-ID: 20261015-vhost-vdpa-unpin-68ee785a019a
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>,
        =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
        Si-Wei Liu <si-wei.liu@oracle.com>
Cc: kvm@vger.kernel.org, virtualization@lists.linux.dev,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Tal Zussman <tz2294@columbia.edu>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793468749; l=869;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=yEsTLW5bz4gADvidYrxq5nthN1/BGAv4JgsFze3VSmg=;
 b=jeyY9hiphQ8blprG87I1oONkrIN8Q7ZL/IGjRLJbSRY/hU0x0AZTh7Gso9PmhW412uIWzzlh+
 JxQxyJSbDs9CNUNDmGS7lxZEUsybN2nVwItY57qixt33KLSfa4cYQmD
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMxMDA3MCBTYWx0ZWRfXx0w+vbMXSJkE
 JgbjQm7pK3ydpYqmNqspzRBlsL/nvKyrq1S2xExjZaUFN4+CCEN5RcoIVcI5qZxJ70by8HnzOSs
 N9fOr2lRU0xPevEt5iE06U8zsN9Sa78LLylI4r80F3xs80cd8Zvm
X-Authority-Analysis: v=2.4 cv=ZIxCCn7b c=1 sm=1 tr=0 ts=6ae62952 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=P+xgYyhW+KadpqoI50EQPQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=azVShVRs0zEubeQ0wG0L:22
 a=mS1D9im87lyf6bhA-bcA:9 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-ORIG-GUID: 0jxMZH1btvLUye9kGSjNASWP3WWuoloX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMxMDA3MCBTYWx0ZWRfX/B6PRXIx7rbo
 njWBSdc8GmjDWfCgSfrIgftE7jHlT08jfV0wNQ14z6qynX+V708nnhlFA3Vs6tSv6dcuty0IVX5
 tmZYgU30q3KoeIHc2ClyqB9iPgAhLAO9PoiC0TmkP2yHeQmalA6ZiIKUcCO7awT5/UKpdmE96Yl
 P4RA+W0pY+rlsig4BhAp3mXeLpFWgnOtIqG9HbhCNPRPH50u636yLU7DNnzYIu9mqKp4l68F4Uv
 aW0d/R8fHPkwlHKlqcAEPKIrAbVnrR65u2cIROHL4ieCb1O50NJGgNcu5O0yk2RuZNezSfsDCH8
 puRD1wbEK1plXmFAkVBu+Lbg65wdErocFIgoRnC1yelIPxlXcU1/EDCNXQS6RfW8XhHzfpdYfl7
 brHypYgDYz0XH7eeZKKICOgHhGVO/0G1vLUTbpcbScUD8wO61M9ccjSrdOCc1gTMSv5G9iPgLIo
 bx+6F5+zpGGzMJ62QEw==
X-Proofpoint-GUID: 0jxMZH1btvLUye9kGSjNASWP3WWuoloX
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11952
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 clxscore=1011 priorityscore=1501 suspectscore=0
 bulkscore=10 phishscore=0 adultscore=0 lowpriorityscore=10 impostorscore=10
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2610310070

While testing the second patch I ran into a pinned page leak in the
vhost_vdpa_pa_map() error path. The first patch fixes that and is
tagged for stable.

The second patch unpins each IOTLB mapping as a range with
unpin_user_page_range_dirty_lock(), which marks each folio dirty once
and drops its pins in one go, instead of a set_page_dirty_lock() and
unpin_user_page() per page. It removes the last use of
set_page_dirty_lock() in vhost.

---
Tal Zussman (2):
      vhost-vdpa: fix pinned page leak in vhost_vdpa_pa_map() error path
      vhost-vdpa: unpin mappings by range

 drivers/vhost/vdpa.c | 28 ++++++++--------------------
 1 file changed, 8 insertions(+), 20 deletions(-)
---
base-commit: c69023b5e16e5ffe9368603dca76d85bd544ee57
change-id: 20261015-vhost-vdpa-unpin-68ee785a019a

Best regards,
--  
Tal Zussman <tz2294@columbia.edu>

