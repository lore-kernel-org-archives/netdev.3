Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792690855;
	b=Rf6Z7/CsXQWZ1wN2Zl6ZeWSIM4pzMuH7Rsu9ToW7apaaBkQmGtW4HU+UDvrMq9UNuaHC
	 z5aiUIuwXYqM/3xoQD0AcoiioeaiOakEOIaLf47/JVjdvnvkbAC9C/VJLa8OXTx88mXAX
	 ynCiFt+Owj0hOMbOpBrqmHZuKZd2vbJUwK1vh0aLdJI54CKj5gx2UTLGBqymwtzT74sfG
	 OW3GlmWAN36MaOi9JOYSgnu+hk2SpOljPpz3MS5J6iFYqSDcIHHAH5Ks9couPIp7uiy1A
	 ZJu6t7ZsyYGjPaTA0YfpoHCy6ukk0jaHIrR/5oWLlT00QepaEaqn1CdNReQexH1iiQQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792690855;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=lqDNdqh7JWi24rY3vzEqU+LCO6MlMl1qL5MbUIf6AO4=;
	b=LGp8dQLP2ksEhtKVanNcXpYW856G0/c+bv+NBYv2VnDCWSHF/jyAAFtDxU9ckpjCkL0X
	 799LM69rZSnFILYf219h81r5XbDfDlJzbTqtrnbUsW8YFk1HbYRrEC1aBrgCoZ/TsQVcD
	 NTFcCJ5u5v1p7xDjwaqqtQi5UZZywuJB1xlr2S7OnINSAUT/91d5FGbdeqsbLfJvq5BPM
	 8I0qDJQFrbnwqOnklQ8wdrnkXmA3acklcqUjrkYDQaTu6mn8L23SUQ0n2VWBV6P3JCScE
	 5EH1jRfD1YpfP8jA3MTYmt2J0AfU8gDlLxnlJOeuF7+0Tj7nxuwuneSNju0MnfZvZPQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=linux.com;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.128.43
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33E6E606A31D
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 17:40:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 33E6E606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4a1fbd52ab6so555365e9.0
        for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 10:40:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792690853; x=1793295653;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lqDNdqh7JWi24rY3vzEqU+LCO6MlMl1qL5MbUIf6AO4=;
        b=RJvezFXDVvP2n7lLkAV0GYsgF/W1lnlfyBy8jxOG+aBUi8CaT6aeWahuNQcpS3v3xP
         FRhOHeTxr0V84HfvGe0jjx2Y7ilClYr7Cltf9FMuakt3tQfvRSqgTlPO2xH+wyQtMuyC
         KiaqMPk4CL7A+0uHaj9JKlHEAXy0Luc7q09UXtrywtXIwK926OdW/h8cylABkIpg8jfC
         NAxCkp8bQ0maw7I1GLeUW4mfbWPXN1MXtMzqFBmiVeHrIMkm4pYo58dkHp3UEuDOejqi
         ly8R5jlWcIT+/ZlLRuMp+5mVKfNcBLsRzHS10Oo49IHlCfSrmkgzOR07a9iYlc831yKs
         cYbA==
X-Forwarded-Encrypted: i=1; AKwUvBxhuaQxMXDzcDOyULxEZaEHTbeHxAciXQ5LyKiTsd4Lb1dudX/1NYEK3kDcXwcRL6uGNarZ7zs=@vger.kernel.org
X-Gm-Message-State: AFq9FYICq4aFb17LTd+Iijz0ynw3vXFpiVYh4WqKuyvVL8nhdnKWA7Bx
	l0vJOem2mtnwyYdJUCgOpMOyVKhW3rCSui5MkbfY/zlYyBivCGMbySkU
X-Gm-Gg: AYBFou1Ly4PxdevuaGilFBtif/YkZrGWZY28wptTQLJ7tNnmu3gx3wgh7hfiQ5abAko
	Cluqjkiz/cDiM0E9sPfmMvsjD7UGGc7SDE4/2nuHJGHIRozL9hZsXPOQKRzMOryeqvxxU+5YYMg
	LfMu0qDK8Z84oS8ebd+d3S/tkF7EpujadwpKzejTJJqta6afptp9Yagrv760WOvvJbRohKjSA3S
	kCL0n70AGsKNDJwPmX2yzJNbAAKV4vN0JdEKskQz/dzrpDflwWhvzUP9NoE4Pst6sYxUQLkDjSh
	d1hwfVyXRF/86/OxqE1kHOx9+FeqSompqvksWq8XPU5zkQOCWMUFdM2sm5sDizqclJI5PrhzV6E
	nDM+Xs2B8bAAylQfFJvMUjG6EtJwV/67NflVk+xIvyJOkk+A4Zv1RmV628xi8QNAauiRQNuuGjd
	XYJmaGye91vuGP5F1E6j76cpnL4qV0PNQjbFTBwwvf1xBaFBgrydIAjhwmL09CP6VL3e8csGx3E
	MfTWHoOiUMGoTAu7aGOuJRyW8M8wD9OciFj/kKwqLW3TmpQnkISYplXkRmyudJ1nNiXxL5YnmrT
	/HO368g/8Q==
X-Received: by 2002:a05:600c:8b45:b0:4a2:a3b:7aa8 with SMTP id 5b1f17b1804b1-4a20a3b7c0emr41739035e9.3.1792690853435;
        Thu, 22 Oct 2026 10:40:53 -0700 (PDT)
Received: from [192.168.1.135] ([81.79.62.202])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a2101cd7cesm14216005e9.0.2026.10.22.10.40.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Oct 2026 10:40:52 -0700 (PDT)
Message-ID: <74840159-62d9-4d6d-a0c3-b079e6e4da6e@linux.com>
Date: Thu, 22 Oct 2026 18:40:51 +0100
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 7/8] arm64: dts: amlogic: t7: khadas-vim4: enable the
 ethernet port
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: xianwei.zhao@amlogic.com, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20261010105900.247342-1-tanure@linux.com>
 <20261010105900.247342-8-tanure@linux.com>
 <CAFBinCC8iKESoc2zEXJMEmqk0cwWbVap-a2KcAtB7-KFKO9Atg@mail.gmail.com>
Content-Language: en-US
From: Lucas Tanure <tanure@linux.com>
In-Reply-To: <CAFBinCC8iKESoc2zEXJMEmqk0cwWbVap-a2KcAtB7-KFKO9Atg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/10/2026 23:00, Martin Blumenstingl wrote:
> On Sat, Oct 10, 2026 at 12:59 PM Lucas Tanure <tanure@linux.com> wrote:
> [...]
>> RGMII needs a delay on each of its two clocks, and on this board
>> both come from inside the chips, not from the board traces. The PHY
>> adds the one on receive. Its transmit delay does not work here, so the
>> controller adds that one.
> [...]
>> +&ethmac {
>> +       status = "okay";
>> +       pinctrl-0 = <&eth_pins>, <&eth_rgmii_pins>;
>> +       pinctrl-names = "default";
>> +       phy-mode = "rgmii-id";
>> +       phy-handle = <&external_phy>;
>> +       tx-internal-delay-ps = <2000>;
> You're stating that RTL8211F's TX delay doesn't work but not explaining why.
> I haven't come across this behavior before and I'm worried that that's
> an issue with a batch of RTL8211F.
> What if the previous/next batch of RTL8211F will have working TX delay
> again - wouldn't that mean 4ns delay in total unless the RTL8211F
> driver is changed?

Yes, you are right. After I understood I had a missing clock I re-tested 
the everything from scratch.

On the T7 the register block with PRG_ETH0/PRG_ETH1 sits behind a clock
gate (the "pclk" clock in patches 2 and 6). My first tests ran before I
knew about that gate: the block ignored every write and PRG_ETH0 kept
the value the bootloader left there, 0x1621. Bit 5 of that value is the
TX clock phase select, 1/4 cycle, which is 2ns at 1Gbit/s. So with
"rgmii-id" the PHY added 2ns and the MAC added another 2ns nobody asked
for, 4ns in total. The CRC errors from that made me believe the PHY TX
delay was not working.

With the clock enabled and a plain "rgmii-id" node, no delay property:

   PRG_ETH0 = 0x1601 (TX phase 0), PRG_ETH1 = 0x0
   RTL8211F page 0xd08: reg 0x11 = 0x0109 (TX delay on),
                        reg 0x15 = 0x0019 (RX delay on)
   iperf3: 940 Mbit/s board to PC, 943 Mbit/s PC to board, 0 retransmits
   0 CRC errors on both ends

v4 drops tx-internal-delay-ps from the VIM4 node and the wrong sentence
from the commit message. The PHY adds both delays, as the generic text
expects.

Thanks
Lucas
