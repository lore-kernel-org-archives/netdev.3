Received: from sender6-op-o12.zoho.com (sender6-op-o12.zoho.com [165.173.180.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31CA734BA24;
	Sat,  3 Oct 2026 15:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=165.173.180.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791041068; cv=pass; b=DgaqSL2NDzAZOMIFYVxc0bwbfPT75zpJRnge48vr43v6oYNreHfGrmgpmBgGRWJCMgyznY36FSgp7lGCyCtq9zWH02iQsd3kGQOM9WEzPMXhBkdsU2ZwiMhfYO50wI7v1j/RosXXecgxvwX70PVFBNFdSrmpKnJZqCv7E5PTV2c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791041068; c=relaxed/simple;
	bh=m4X/RhhMPONFFNOGIFwjTcEamNfPucpOxeJgUJZ/0xg=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=PJiB/lRs+7ei6t1mMU6WZ5fJ/ULUE/KydKJiNScufLLUjJSH0C1cE3YbJp4Mq268zkqKSVEwXL/ymuAZxxhsMAhDM0nkFPFrgFOP+ZO6eXTNMdySssCF6CCP4En/OAFz2SlJIP8wF/wAQDw0DBinxd751YociuboIVd9mP0yLwA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pigmoral.tech; spf=pass smtp.mailfrom=pigmoral.tech; dkim=pass (1024-bit key) header.d=pigmoral.tech header.i=junhui.liu@pigmoral.tech header.b=mR/f9bi1; arc=pass smtp.client-ip=165.173.180.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pigmoral.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pigmoral.tech
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pigmoral.tech header.i=junhui.liu@pigmoral.tech header.b="mR/f9bi1"
ARC-Seal: i=1; a=rsa-sha256; t=1791041012; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Mla9QlvbKLfkIGm5F8CLZaJ0IQ2tiUxPFt+eAf2jLpuoig8zEBtn5uQsaJ5fe+elg6gB69uM9dXHYX9ayyO5LmTGJdop/MOrRhNpHrdo0qdObawACrVXlXAWDQ0qgfPeeT6XKTqCmDO9IrWMqnd9gA+Y+Q7mchB6dc5Xp5kBwVw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1791041012; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=m4X/RhhMPONFFNOGIFwjTcEamNfPucpOxeJgUJZ/0xg=; 
	b=T4v4+0UI7Q4e5xYrfbMQKzgVpyzxQncJImxKtVRjbWv7lTg6QmYaeWR6QvDA5LdQBbBqDdsyR1deGQIQxq0zD/Ha+zs+5fqXqcz/1tFspaK3fKHcVt2nlldw7tJfD1ePxqM5dhAGpzi7YDhV5b476VZ4FjjWnhd4NLeVdxxbzCQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=pigmoral.tech;
	spf=pass  smtp.mailfrom=junhui.liu@pigmoral.tech;
	dmarc=pass header.from=<junhui.liu@pigmoral.tech>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1791041012;
	s=zmail; d=pigmoral.tech; i=junhui.liu@pigmoral.tech;
	h=Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Date:Message-Id:Message-Id:From:From:To:To:Cc:Cc:Subject:Subject:In-Reply-To:Reply-To;
	bh=m4X/RhhMPONFFNOGIFwjTcEamNfPucpOxeJgUJZ/0xg=;
	b=mR/f9bi16V5mpGJwGJF+eRlDykL3W+2i8B+eqzU1eydlpkvJ17Svx0r+gWyIP7/A
	MS/k9V7KXnUWpgm7pwW1H7ihOCim1+nTZ0tyTCX0T59AV4i5TxafSGCaa8Nl+mtGLua
	Kw8NwmBd1xY5WSb/ol7TylPdSFTELIhIWejKV9bw=
Received: by smtp.zohomail.com with SMTPS id 1791041011797544.830040683923;
	Sat, 3 Oct 2026 08:23:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 03 Oct 2026 23:23:22 +0800
Message-Id: <DLVB1PLRC8GV.2YX3NP2B1KV2A@pigmoral.tech>
From: "Junhui Liu" <junhui.liu@pigmoral.tech>
To: "Norman Herms" <dockseed@proton.me>, "Junhui Liu"
 <junhui.liu@pigmoral.tech>
Cc: <wens@kernel.org>, "Stephen Boyd" <sboyd@kernel.org>, "Brian Masney"
 <bmasney+clk@redhat.com>, "Jerome Brunet" <jbrunet+clk@baylibre.com>, "Rob
 Herring" <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>,
 "Conor Dooley" <conor+dt@kernel.org>, "Jernej Skrabec"
 <jernej.skrabec@gmail.com>, "Samuel Holland" <samuel@sholland.org>,
 "Philipp Zabel" <p.zabel@pengutronix.de>, "Paul Walmsley" <pjw@kernel.org>,
 "Palmer Dabbelt" <palmer@dabbelt.com>, "Albert Ou" <aou@eecs.berkeley.edu>,
 "Alexandre Ghiti" <alex@ghiti.fr>, "Richard Cochran"
 <richardcochran@gmail.com>, <linux-clk@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-sunxi@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
 <linux-riscv@lists.infradead.org>, <netdev@vger.kernel.org>, "Jerome
 Brunet" <jbrunet@baylibre.com>, "Enzo Adriano"
 <enzo.adriano.code@gmail.com>, "Andre Przywara" <andre.przywara@arm.com>,
 "Krzysztof Kozlowski" <krzysztof.kozlowski@oss.qualcomm.com>, "Yixun Lan"
 <dlan@gentoo.org>
Subject: Re: [PATCH v5 0/8] clk: sunxi-ng: Add support for Allwinner A733
 CCU and PRCM
X-Mailer: aerc 0.22.0
References: <20260930-a733-clk-v5-0-11175b41cd2d@pigmoral.tech>
 <CAGb2v66O7Ze=TiHO_5q=76QpU8ZXraFyV+HfO+_HpkTDr1U-nQ@mail.gmail.com>
 <DLVA17A4RRG7.2ECQKV3SJDAGI@pigmoral.tech>
 <BZm0Br5_P98xkwslO2JLeCMSyqps8EfQzDnH1Ox34cpoxCpkznXDa4RUM40-b1WKuZ3w3Cy0LPBE31oL8T1nq1Z8iT9Z51wUJBRp3iQIn-Y=@proton.me>
In-Reply-To: <BZm0Br5_P98xkwslO2JLeCMSyqps8EfQzDnH1Ox34cpoxCpkznXDa4RUM40-b1WKuZ3w3Cy0LPBE31oL8T1nq1Z8iT9Z51wUJBRp3iQIn-Y=@proton.me>
X-ZohoMailClient: External

Hi Norman,

Thanks for testing this. You saved my A7Z board from an almost certain
sacrifice. :)

On Sat Oct 3, 2026 at 11:05 PM CST, Norman Herms wrote:
> Hi Junhui,
>
>> Thanks for pointing this out. This is indeed something I had not
>> considered before. I will try enabling secure boot on my spare Cubie A7Z
>> board and test it on actual hardware.
>
> First a correction to my earlier reply in this thread. I answered
> ChenYu's "presumably ... the secure/non-secure access bit isn't in
> effect" with "yes" and quoted the UM note that these registers are
> always non-secure in non-security mode. On our non-fused A7S boards
> (SID + 0xA0 =3D 0, also when read from EL3) that does not hold for every
> register. Read from EL3 with a test BL31, CCMU_SEC_SWITCH_REG is 0x7
> after BL31's security setup, S_TWD_BGR_REG is 0x1 and the SPC status
> registers are 0xffffffff, but from non-secure all of them read 0, and
> non-secure writes to the first two do not stick. So secure filtering
> is active on these parts even without the fuse.

I will double-check this on my side and add the relevant comments as
Chen-Yu suggested.

>
>> For the PLL and AHB/APB bus clock controls, the user manual indicates
>> that the relevant security bits can be set by TF-A to allow the kernel
>> to access these registers. This also appears to be how this has
>> traditionally been handled on sunxi platforms. So I think we can do the
>> same in TF-A for the A733.
>
> That is what the BL31 on our boards does: PRCM_SEC_SWITCH_REG |=3D 0x7
> and 0x7 to CCMU_SEC_SWITCH_REG at CCU + 0x1F00, as the vendor BL31
> does. From EL3 both read 0 before and 0x7 after. The 0x1F00 versus
> 0x0F00 trap in the A733 TF-A port is in my first reply.
>
>> For bus_r_twd_clk, I will test whether the register is indeed always
>> secure. If it is, I think the clock can be removed from the kernel and
>> left enabled by its hardware reset value or by the boot firmware.
>
> On our non-fused boards it is already inaccessible from the non-secure
> side (reads 0, writes ignored). From EL3 it reads 0x1, the UM default,
> so the gate is open. Details are in my reply to ChenYu on patch 3/8,
> which crossed with yours.

Understood. This bus gate is therefore not meaningful to the kernel,
so I will remove the clock in the next version.

>
> Same boards and caveats as before: AI agents (Claude) on my boards, a
> report, not a Tested-by.
>
> Thanks,
> Norman

--=20
Best regards,
Junhui Liu

