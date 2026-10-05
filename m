Received: from mail-lf2-f12.google.com (mail-lf2-f12.google.com [74.125.229.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EE8741D10D
	for <netdev@vger.kernel.org>; Mon,  5 Oct 2026 23:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791243533; cv=none; b=hSVTaedxHO+9T8kLyb6T/Ev+HaEwRGMhPzCd3zX4ams6nQLFdb7gMwW1brHlbki7SZYoekfD08Gy8HFG5n4PfavA06ozOcK2FEAB8oW50SgFUMfuN2c9k4OxVx3sEIiSbZLeLELG1Mt+8k5VDhe48eSsyBJYQjgv7HmfsXdCp7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791243533; c=relaxed/simple;
	bh=k4VxHYPDQlNlaPiDWtm0njKpKpXdpMpaZHAGx8QED6I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mbp4aOVadzEDUNomEIC2NpOOKu/lUtbNkagYm19BLbctMKQ2WwHRsNC+zKvJ+hMq1VyQHf+TEcXVQBkaecoWx+8XeQ6UEeN52jzFSPvFD+rUZwR6c1X3eA/k9NjYkndsyRjwKoULOO0/NHVG0ArChD07UytK2gG2HxxsXbZzRw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pbGV2UM2; arc=none smtp.client-ip=74.125.229.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pbGV2UM2"
Received: by mail-lf2-f12.google.com with SMTP id 2adb3069b0e04-5bcbfb28053so1306247e87.1
        for <netdev@vger.kernel.org>; Mon, 05 Oct 2026 16:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791243529; x=1791848329; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+DTqPd+FK0C59toCv/w+p9Wc2puRzcD2Gcg0RCLDBBo=;
        b=pbGV2UM2rQpCCDkEEV4K+AKxKPAmzMlSzCNffeKbdlhzGt2JMPJwaDYYuiSsVidVAn
         wmZB+38dcDO/yVakIFi/S2ycJGWBEjSavDiYmj5tVI+ZiKrDKZXf2fH/vW/4s8/Phxyo
         uibgSA9ei135CeEnZkPUm9iX/2TsUHCmvFqOLfhX2Y28+19iGmaBs7awuw+N6Ia9cDh8
         PeGLd0GZvrfcHjWvrYV/GJseVBBYUp5yt+5m5rYI92b4Ng8eAkhqgZrDwwSnaPTukLDz
         OI5hdQOPCkGL3J0KC4fT77uIJF5FbfYqwoj6bAh0w6uIqjuJpHkeTXVBDAhsLYy2qr5q
         ObmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791243529; x=1791848329;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+DTqPd+FK0C59toCv/w+p9Wc2puRzcD2Gcg0RCLDBBo=;
        b=ot84AhXUhwHJNk3+ZEFto3RiDv1FpGrLSLZ+zKfuc5/8ZywNK6WRyF6Sr8WVsf3sDd
         A2MD6Ta/3IigWTJFdpC2+x2cuWll7qlUa9m1g2buOO11H7NMnomeTYC3UTRQq3hmzsO1
         wCTqX/x8nwZ0P9bgnk7gUUmZPCmM8Yk487RBpijZzN3rZUUy078kl2Ic912A9R8HJMTb
         IvMBOmsfK5EMYlMX1lY5JtKtEXdDEYges6UBSoxX5rlwXYIl5/duxCyrk4Op6aDDl6Hw
         LAbzjYVTLruUBpmAzK+ZJuELt7AqfQt/RhfIj7wB9PKJvMVKunrc/MmcAuGZhMpL+qG6
         YStA==
X-Gm-Message-State: AFq9FYICmfpPU9AB/1phviC/vkQx4UjckzUhxxqCeufEj+Oejp7BP7Ya
	yzVnhaTf3tjbex6FCuvz9QdIPvfDtGaThEyVix+A/PhexjMQrpAK60G+
X-Gm-Gg: AYBFou3fC2wcWisaYYDWRDr6o3cbXQPkwfEVq2pzyve1Z25ZcHBWBSlq/SIvhjIFtBO
	4hb315A3g4nXNqnyxrxBV1TSFHdFXKObUtZ5mOZXFmW4qIQKEjTcGPH/gPeg0FjgPsruPp8+OdW
	52ODzmj+gluPAsCAx7BOUs4k6aopbrC5JzKz+SjionVwbB3rwEz3oWXBcGH9Rw9DdKVR1IwtzYl
	OTBXw1NZxnHIYFQMVyLz2wMhXoS4qtkhJ0mfqCEBCuaKl152mX48F6tUCWfSSAopeqLqFajE+VS
	urrV2f36cOpWwjogFqoRSM2VU8N1ZnZnpxtzqEa5E+7hG8AzNprskp1q2NrlQjiPxKo5rtIKjtp
	Q6YjaEYILPjy3tvtagT19AVq3gDPAaOu00DYVjKi5KABxkKclNVZ2uMsHsFzzPD98fqQxTyMy87
	q+lqC5gmfUwvQol4EdCblXH211l35+cg72HGY9klfizk1AdRir/wKb2JlrANqvnYRTJATEFehWE
	ZSX36bKdfbpwC43DVWTe5bfJ9WpuR9p7njVZC1GBQ==
X-Received: by 2002:a05:6512:3d21:b0:5ba:4264:da4a with SMTP id 2adb3069b0e04-5bb9bc5b39emr4566381e87.63.1791243529358;
        Mon, 05 Oct 2026 16:38:49 -0700 (PDT)
Received: from dau-home-pc.. ([212.35.161.1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5bb7c7195b3sm3627196e87.8.2026.10.05.16.38.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 16:38:48 -0700 (PDT)
From: Anton Danilov <littlesmilingcloud@gmail.com>
To: netdev-bot+sinfo@kernel.org
Cc: netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	William Tu <u9012063@gmail.com>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH net] ip6_gre: let collect_md ip6gretap send from the unspecified address
Date: Tue,  6 Oct 2026 02:38:41 +0300
Message-ID: <20261005233843.936597-1-littlesmilingcloud@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <179122803467.1402591.12893544301783319251@kernel.org>
References: <20261005191227.894665-1-littlesmilingcloud@gmail.com> <179122803467.1402591.12893544301783319251@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, Oct 05, 2026 at 07:20:34PM +0000, netdev-bot+sinfo@kernel.org wrote:
> This is an automated message. This series looks like a fix, but its
> commit messages seem to be missing some information:
>
>  - How the issue was discovered, e.g. hit in production, hit during
>    development, syzbot report, manual code inspection, LLM or static
>    analysis tool scan.

Hit during development of the net-next series that annotates these
drivers with drop reasons. An LLM-assisted review of that series
flagged the misleading "dead loop" reason this check gives to frames
sent from :: when raddr is ::. Following that up with code inspection
and testing showed that for L2 collect_md devices the drop itself is
wrong, not just the label. The review of that series on the list asked
about the same case, and this fix was promised in the reply:

  https://lore.kernel.org/netdev/20261005174649.853236-1-littlesmilingcloud@gmail.com/

>  - Whether the issue was actually triggered, or is only theoretical
>    (e.g. found by code inspection). If it was triggered please include
>    the symptoms, like the stack trace or error messages.

Triggered deliberately in a test VM; this is not a production report.
There is no stack trace or log message: the frames are dropped
silently, and the loss only shows up in counters. With frames bridged
from a veth into a collect_md ip6gretap device by tc (flower +
tunnel_key set + mirred) over a dummy underlay, five DAD-style
Neighbor Solicitations sent from :: give tx_errors +5 and tx_dropped
+5 on the tunnel device, zero packets on the underlay, and five
kfree_skb events in ip6gre_tunnel_xmit() (reason NOT_SPECIFIED). The
same frames sent from a link-local address are transmitted. With the
patch applied the frames from :: are transmitted as well, while the
check still fires for native ip6gretap with a configured remote and
for L3 collect_md ip6gre; each half of the new condition was verified
by removing it in turn and watching the case it protects start passing
frames it must not.

---

Anton Danilov
