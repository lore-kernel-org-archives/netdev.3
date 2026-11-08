Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794141286;
	b=1PXVAzYhBnLRPHuPhFguudtWDBiLOCyGA06DoeX5lwq0ND+HA2zJyDtECLY03E8PvgK/
	 o6YXFha4OUs+PHAmGGPDR5e5xip9jlgqwce+5iLEYNQ/OwAd8Hj+bJAxv9SHdS2RBE43R
	 wMLKEKu7JD9JJhyop5YIweX6rFj/ays23Em++ZfC8o/vvEARzb3aTaDh9rkOkkWrgL2lw
	 50ZQ1jpRKRxow1de7badXEdEy3dsTIc5fhrVF7F3gVgTU9XhJLIj9osMqGVrpqtuSr//4
	 eY177kr7+daS4pVNjVX9OBq/FpnYnEf7C24Pue+8tNJo6KhxM1Cbc11A2d2Krzlv6/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794141286;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=fOZEfPbkpDcUaP0mBLPSnsv8fE4ioirCVy7jzR22tC4=;
	b=wRVoI6NEslyIbSqoHHVRvjo/A3FK2TC0kJzuD9u9A5CMAED2sWyn3XXzGMMqXIGsZyeK
	 j2kaKYQtSuBYsBG7V05hjZtkQh0qYWtDnWOY6VMlu7OnnxoplPC8Rry/hM+ula8JwMQni
	 Yn5wD8Br4pwTnOMxdlERfMIZAgvlMJ2kN1gR/fUeoe47Py5V7nnEnT/+YBENe4ppvKS/G
	 bGdfhPRnkDFCK3hC+cyn9urXqwzf7CVWro8v42SDlT4EHTJx2aClC3q4uP7OxyuJlM0aH
	 fHrHmHlP8g32dy0n9qSXv+uyGJLuSPyTnv+p+3z2BYLZeGIPVKuOVmRgXxfmFLlqfsA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eH2WZQCq;
	arc=none smtp.remote-ip=209.85.128.169
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C667606A31C
	for <netdev@vger.kernel.org>; Sun,  8 Nov 2026 12:34:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9C667606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eH2WZQCq
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-8b308fca7c3so233847b3.2
        for <netdev@vger.kernel.org>; Sun, 08 Nov 2026 04:34:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794141284; x=1794746084; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=fOZEfPbkpDcUaP0mBLPSnsv8fE4ioirCVy7jzR22tC4=;
        b=eH2WZQCqohh3ZJL9JRPl4XVfAxk4PlENe5FMnO43jrWAFkPkWOtSNC8UupurbmgryD
         I6pBz6m1BrZIiYw/pBD98CTalo0Uct2IOD61fMDiO3SodxAHEbcutIEazv9vY7/0OrVe
         bzXlxUNghxhrmL+LPp4K8BYfk0k+rjFe893do6FFZLDCN1pRSSIcTiLPyY/gPx6fNEn0
         9rrVnLfyTCVfL3KKZS35VpaWyGcMe/huNkk2yvZiuU8cHCQyD1Dhv56KrA7gfEapCpgv
         EMRgQcjRA4JILeXgsqpBJeUtzAmnwqCmytiESjPWC3bXUXzqXzaOnntBRALtoZVD7qi2
         gGCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794141284; x=1794746084;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fOZEfPbkpDcUaP0mBLPSnsv8fE4ioirCVy7jzR22tC4=;
        b=f40wxuxq6FRrUwdC4cc6w4ilEsk8eBTu3DQMUTXCb2bLAGerhSbPES7K7SnUK+ogYN
         09F5IYIfPmKZuF9b/DC9YFxzXaa2MqlIuG54ZdlIgK24Bvsbc2XvWoRLWbzFMKzjEV2d
         qv7twHoLn1bZ6zbalT30uvCcAa+ws659UVTLJFPQ+dc5cpoPKj1eqA9CgSBm2bdvVjWX
         aZEvT+0BANrNR1uXFaEdro2ammY+YlnK4JnRu5ao3prC6bFjSe/ca24JwZfG0BdPhxc6
         4tj85f99oyiiFGPS25FiBOfC+egAEckR0M74QbVuiI404JhZJsFmk+bTdOCUxVbe4iju
         Thuw==
X-Gm-Message-State: APuU4Z9sCCG20IGU54wkP0KmzO4YaSTIpBrdpIPummxyNaoEoxq8Gz5i
	2MW1EOk39Ar0yzwxMZo+0w5Bxc69V9KJdtSRDE+jLiDvvAC7K4RzJ9jEA8hmmAFk
X-Gm-Gg: AYBFou1w/a+8oWJWszE0Wa/n46sVjjYbdi9RriHSyGWTaY7VWErQuwI8DpbkePFKeUR
	fpCImVTeDCTM7Idk06QTFdYsAFfwoNu+2B/eKWo3Ge73j2vTqp5uDgf9HweYSvRvvhYgxq3eNQd
	UqkDG4JLweyo2AW0rSEjIOSyxQz39hykCMRqt2XIIcvdJkdheAnkouvV51kYI42oEXU9jPN3Dr1
	Q0VW4a/pHQHNpgNIfh7cXpQPWFoVpQA0bwN8ThSx3zWQeO2kBeZSP/CHb9CKYJ2fG+Zj+yu8FTs
	OiP9wVezv41kUPy1VQLGrn+gQQmRpUeMUNxPdcGTFKd8chlERa5wVn/8HZKivPxwloDMvJl9DPE
	ZhQjXEEB6c+A7h4XGZngyTg5oOC2OFk/9V4xq6N7qMTHCuqdR9b4E0y8mgpj7IhzaxRIqKGAEr+
	/Nb49QEUNqkVqt3eJcz+alNEGSw1+eGMC3qJAP1bxgmvXyxPez0QZ2ktV9nUS6c6/ZjIX0OU36+
	DBWFYfatMw2t6TLYLSlp6o3F3D7lROtrXsVNI/DAv8kWFa2MaeA6x/Pmp+LIAv9rvFkEh9w5n4H
	kOLulYDVeifbQHzZiP20mpu1zY7ZOfnN80GXfk8jPjl4tQ==
X-Received: by 2002:a05:690c:68f:b0:8b3:3fc5:2be with SMTP id 00721157ae682-8b36c9c514cmr8721117b3.20.1794141284574;
        Sun, 08 Nov 2026 04:34:44 -0800 (PST)
Received: from houminxi ([61.170.225.237])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b36be7d88dsm13475627b3.39.2026.11.08.04.34.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 04:34:43 -0800 (PST)
From: Minxi Hou <houminxi@gmail.com>
To: netdev@vger.kernel.org
Cc: Aaron Conole <aconole@redhat.com>,
	Eelco Chaudron <echaudro@redhat.com>,
	Ilya Maximets <i.maximets@ovn.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Paul Blakey <paulb@nvidia.com>,
	dev@openvswitch.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net v2 0/2] net: openvswitch: fix a feature leak on a failed change
Date: Sun,  8 Nov 2026 07:34:22 -0500
Message-ID: <20261108123424.2825403-1-houminxi@gmail.com>
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

Changes in v2:
- Patch 1 limits its closing claim to OVS_DP_CMD_SET, and says that a
  failed OVS_DP_CMD_NEW and the reset that follows it still leave the
  key one enable ahead.
- Patch 1 names the reachability and the effect: only CAP_NET_ADMIN is
  needed, datapath_policy does not validate the per-cpu-pids attribute,
  and a disable on a count of zero warns in static_key_dec_not_one().
- Patch 2 treats only EOPNOTSUPP as the missing key and skips with the
  kselftest skip code; any other failure fails the test.
- Patch 2 selects CONFIG_NET_CLS_ACT and CONFIG_NET_TC_SKB_EXT in the
  selftest config fragment, so the recirc round runs in CI.
- Patch 2 sends the features the datapath reports when --features is
  left out, instead of clearing them.

v1: https://lore.kernel.org/netdev/20261107113403.797779-1-houminxi@gmail.com/

ovs_dp_change() records the requested user features before it calls the
update that can fail, so a request rejected for an empty per-cpu-pids
leaves the datapath claiming a feature it never enabled. The tc skb
extension key is a reference count shared with cls_flower, and the code
that would keep it in step is skipped on that path.

Patch 1 fixes the ordering. Patch 2 adds a set-dp command to the
openvswitch selftest tool, and a test that sends such a request and
checks the features the datapath reports afterwards. It fails without
the fix and passes with it.

The problem turned up while the YNL spec for this family was being
written: describing the ovs_datapath set command meant reading
ovs_dp_change(), where the ordering stands out.

Signed-off-by: Minxi Hou <houminxi@gmail.com>

Minxi Hou (2):
Minxi Hou (2):
  net: openvswitch: do not record user features when the change fails
  selftests/net/openvswitch: check that a failed set keeps the features

 net/openvswitch/datapath.c                    | 10 +--
 .../testing/selftests/net/openvswitch/config  |  2 +
 .../selftests/net/openvswitch/openvswitch.sh  | 67 +++++++++++++++++++
 .../selftests/net/openvswitch/ovs-dpctl.py    | 53 +++++++++++++++
 4 files changed, 127 insertions(+), 5 deletions(-)


base-commit: 30c71476d842b094651bd7712f6c8ee8716147d0
-- 
2.56.0

