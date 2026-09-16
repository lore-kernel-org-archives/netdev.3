Received: from mail-pz2-f41.google.com (mail-pz2-f41.google.com [74.125.228.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1540D4D9908
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 23:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789602454; cv=none; b=c9OunXtlh82eNBYnUR/SY0h6CWSpycMX5Sp8li/kyHJoDTVona5ueRJMkeVnbMxqwdUvZi38ehbWkuu083YZG63/sCEfSdCgGkyffqi+MIrJNioDP4VtHVNmAAcvUAAWxdNTHghRLLnV1VJ+VFZjj6xjwstzePnOsQxofTu9etI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789602454; c=relaxed/simple;
	bh=0StVLNOCHGYb/IBVyZGs6stjIE0YL3boBOy+0BdTbBU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ejnEpqUqpxv0kueyp3YicgUJCtH7qTbsCsHB6LOBUOMutBMIIGFOD8X8YqLJuoscybyDO3QRgeWUwet6DWduIfJSdK4uFSKVrrdA3QX+8soewTbQ3WcmAPzBMWEPMSENbhVKB4/QWIIA7ozbrphTcYe74w8SlNfStr3d9NirpOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=hfaToMk7; arc=none smtp.client-ip=74.125.228.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="hfaToMk7"
Received: by mail-pz2-f41.google.com with SMTP id d2e1a72fcca58-85469b35601so152740b3a.3
        for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 16:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1789602451; x=1790207251; darn=vger.kernel.org;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0StVLNOCHGYb/IBVyZGs6stjIE0YL3boBOy+0BdTbBU=;
        b=hfaToMk7uLW3uMcJOX+MJY8eiLXm4WevKCBaJUCdMcsRrS9ADFEoOdZAX3fBeUVhOS
         iJGfAAtADeDAz5U30RhDdKh9oiSO7nq6bwxQVUzMEG+EPP2+7PL/I88Fh+6wSjNoEgC+
         trC8OyhTSmLZJeZODGcK9hirxAi49DiqQtbonHEzjWtu695yc6UhAbspR+Y8FEyT9TR8
         0p9UEgMxN+VTlKnPqBS5ediV5XtgdzPkVgeKOpDGZNgJLrDcwh5K6rZOAIodd4dokOFw
         nJnwq4OjciYxmuRUu+KNp40FoRMrXpuNufeQWQtzgP1GO5xzUs6TBtlW5SVWh7uY7yF0
         oZ2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789602451; x=1790207251;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0StVLNOCHGYb/IBVyZGs6stjIE0YL3boBOy+0BdTbBU=;
        b=NGbIpvzIz2lt6XChFnCrkbYeBdXEn2vVhaWoIGwxSEP3KNokNoU+r0eY1NgCWj0FlW
         2y3xlZVCT8Xvd01mAECK2Q7MgkiIQTgCTJbxzmPKda/yGo1WSZst70QJdquUw0nNTpmC
         F0c9/h88w4N6tYYPOPTPgUxrJCbyPRpMQWLPPAP19GC4op+fwi3HVaxxKPpLLcBHhf6c
         9Hrb02NPF8Fg+cLGMY2vYkKxgZ0G97l8b9SLznt1Fqqu855d48u9WQnn5PIZWZ8HDRxI
         WKQ5ZVZ4YJVboNYFg8xLQ9mUwGlvBp4h4vaxzwkwapS+Q0wYjsrrywh9DhWjEpgTrSf6
         EONQ==
X-Forwarded-Encrypted: i=1; AKwUvByeqVINuRNjBLBA3Tdv6MTryq+yEZhkoy+d55eEsDreStBgTuXDfQ/kwtqFlT7TLaASlKlhfc0=@vger.kernel.org
X-Gm-Message-State: AFuF++nyvj/9heJNUDv2e4KzB2bYsFROtyDMzBDZ1yKD3m4pwOupenvF
	pqtLFBo1wHeYEFghGMNNR3k1P70fY9f3JfW1Zrzrir6iVEU2b5y9ujN7xvrbg1PIJg==
X-Gm-Gg: AYBFou0XlotIUvpK4dAeIjkI0Js9Fo7yo5rrLJbxi+yz8bFv4hgnN+mour4HC3IyQ+c
	JC0nR7h2nCU3ud0sUS+ylCosB0yNodXgV6IoQTbqh6dTpzQ010f4onZUp0HGvGF/C0HaeFwMocA
	Yj7ko5Opn3vyjxv63jPOrjYWMgAY18edz/zyMnap+S2XJQINyC8UDf1czJf2BCxx8T3PUjOraKS
	PdWOCvv/YF0FaqG8vZ2S7zpc/5+tNSqZg5aiTclM6hD4S+CnNQ7btH1a/fsTndszRI9OASmEE40
	dUuAjNHsxSkaT4T09lsM98MrJInK5jIe/U+BUWaI3XBTKLlwtaw/FsM7BRWc7ZboYyinQzsqysD
	S+PH0Ax0DbhDlyWur4aKFvXElSh/lpoU04gWjy14wL0KQYu6Y2d8/zEYpz934M26YNQsKZpJGR0
	/M6SYxq+w3KSLRL4OupHxY6CP+LZlKQ7aQBUMfIoRPf3TZaBSu46vTuhxSnP/bxpaK/meAIhzSj
	NO7tSt99YUuSktCscNJ8Vi3MkQ/dMi2PrHM/ry9+1wIhw==
X-Received: by 2002:a05:6a20:cf88:b0:3db:3d0b:31fd with SMTP id adf61e73a8af0-3dd5f3f86fdmr11720475637.1.1789602450814;
        Wed, 16 Sep 2026 16:47:30 -0700 (PDT)
Received: from p1 (209-147-138-4.nat.asu.edu. [209.147.138.4])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33bf5a9fd38sm10861497eec.13.2026.09.16.16.47.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 16:47:30 -0700 (PDT)
Date: Wed, 16 Sep 2026 16:47:28 -0700
From: Xiang Mei <xmei5@asu.edu>
To: stable@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, netdev@vger.kernel.org, bestswngs@gmail.com
Subject: [STABLE REQUEST] net: appletalk: fix NULL pointer dereference in
 aarp_send_ddp()
Message-ID: <w3zxh3nycm6cdbz6mlgmfi6bnzhdkunbcbu5dwgho2yvxscbjj@ph7wsgy2cxcs>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi stable team,

Could you please consider backporting upstream commit

9e7f36ab5b7bf68463faa5f7b926fea8f35597bb
("net: appletalk: fix NULL pointer dereference in aarp_send_ddp()")

for 6.18.y, 6.12.y, 6.6.y, 6.1.y, 5.15.y, and 5.10.y.

It fixes a NULL pointer dereference when sending through a device
without an AppleTalk interface configured.

The fix has been in mainline since May 18 but is still absent from the
longterm branches.

The upstream commit applies cleanly to all of these branches.

Thanks,
Xiang
