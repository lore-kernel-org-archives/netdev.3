Received: from mta1.migadu.com (out-83.mta1.migadu.com [95.215.58.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECB0D37FF76
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 18:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791830859; cv=none; b=QlVeanPWyhsBo4NAMSQQz0k5RqANZZrO3EoYmonUI3S03ddjSk3v27TmUlR+XvztR56L1pTIhoiiyU52s4iD/z7guh/GbAwuVmoFRGsqQUPnec8Vivc9k9pQAMwiA9w0KR3jqlgn53Th0WNeQjU3XLl3tND9znBtz4WydSLJ+7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791830859; c=relaxed/simple;
	bh=ijNlhyv4xCTmTbbejLtSuQAfF6caH2RK4q9or0ieFkM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZBHfn6mi9VXUoGddQs7T9AOQjpAuxYQrKW0j9193dDAWsZlKamJY+Jqlv2YL8qvPIiRGTXzbMxtmpngu+hqHTP0xm8qPqRAJTUr6GbRHUYgaM5XLIcCoR8xSsp5PGDo/0cnp6oaoqtNxOUmNkzghrXIGxV/y2TDe5ixoXEgnzYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=packett.cool; spf=pass smtp.mailfrom=packett.cool; dkim=pass (2048-bit key) header.d=packett.cool header.i=@packett.cool header.b=ZhGqK3aC; arc=none smtp.client-ip=95.215.58.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=packett.cool
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=packett.cool
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=packett.cool header.i=@packett.cool header.b="ZhGqK3aC"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=ijNlhyv4xCTmTbbejLtSuQAfF6caH2RK4q9or0ieFkM=;
 c=simple/simple; d=packett.cool;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791830854; v=1; x=1792435654;
 b=ZhGqK3aC1dEA6AFriFzlD2Uk6O50NhTH/2K58qAsaTd7mFMFOlu5POxCR+JigEyzvGCWQiDS
 vk5o4HHjFh6qaPdGJL47AyXYO3LgvtuNa4GytcrJULEY/pSR3fMSfhv2og6HKefhVqemO9FJvPB
 Vol8ZNoKL/vfXpXMn+34E/KmdzI4X+XcTh+vqMZyax0+RDMOB5GavCFS7kY4slu4IZ5wYH7LBBK
 6B2EHq0HW5u8aGqg/2o9clsVjr+iUc0kRf3W1547SmPnjYAY0OKplQZ1oqhg2aA92ezHr4bp27P
 k1AOIMo9B1efaHZeVNX677Asu7Vitt1ClXYKYLRopboCw==
X-Envelope-To: netdev@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id f67ebc8caef7985e;
	Mon, 12 Oct 2026 18:47:34 +0000
X-Mizu-Trace-ID: f67ebc8caef7985e
X-Migadu-Flow: FLOW_OUT
Message-ID: <a3464be4-bd4d-4590-9804-147e16016a07@packett.cool>
Date: Mon, 12 Oct 2026 15:47:24 -0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/4] nfc: st-nci: Fairphone 5 NFC bring-up (ST21NFCD)
To: Kristian Brox <isyourbrainfoss@proton.me>,
 David Heidelberg <david@ixit.cz>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Luca Weiss <luca.weiss@fairphone.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 oe-linux-nfc@lists.linux.dev, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
 Tim auf der Landwehr <tadl-git@taufderl.de>,
 Abel Vesa <abel.vesa@oss.qualcomm.com>
References: <20261005-fp5-st21nfcd-v5-v5-0-7be15a86c61c@proton.me>
Content-Language: en-US
From: Val Packett <val@packett.cool>
In-Reply-To: <20261005-fp5-st21nfcd-v5-v5-0-7be15a86c61c@proton.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 10/5/26 5:51 PM, Kristian Brox wrote:
> This adds NFC on the Fairphone 5 (qcm6490). The board uses an ST21NFCD
> on I2C. That part speaks raw NCI; the current st-nci driver always
> wraps NDLC, so using st,st21nfcb-i2c leaves the adapter unusable.
>
> The series adds a st,st21nfcd compatible for the raw-NCI path and the
> Fairphone 5 DT node. Boards that already use st21nfcb / st21nfcc keep
> the NDLC path.
>
> A later poll start that times out in "failed to set local general bytes"
> is still unreproduced on this phone.
>
> Signed-off-by: Kristian Brox <isyourbrainfoss@proton.me>
> ---
> Link to v4:
> https://lore.kernel.org/oe-linux-nfc/20260902-fp5-st21nfcd-v4-v4-0-ded2f1c501be@proton.me/
>
> Changes in v5:
> - Map proprietary RF protocol 0x90 to MIFARE (Tim). On this phone a
>    Classic 1K was accepted as 0x90 and was not dropped.
> - Binding carries Reviewed-by from Krzysztof Kozlowski. DTS carries
>    Reviewed-by from Konrad Dybcio and Abel Vesa. The patch bodies are
>    the v4 patches. The raw-NCI driver change is unchanged.
> - Tim's reference-clock restart and leading-0x7e check were tried on
>    this phone and left out.

Hi, I've been trying to enable the st21nfcj on the Motorola Edge 30, 
which uses the same protocol.

These mentioned left-out patches seemed like they would help, but they 
didn't really. The leading-0x7e check does skip over the "7e 60 00" but 
is not enough to untangle the desynced mess that starts with "79 3e 59 c0"..

sendQlen=1 unackQlen=0
ndlc frame written:
ndlc: 00000000: 20 00 01 01
incoming frame:
ndlc: 00000000: 7e 60 00
incoming frame:
ndlc: 00000000: 1f 01 01 20
rcvQlen=1
incoming frame:
ndlc: 00000000: 02 1a 04 04 01 20 92
rcvQlen=1
incoming frame:
ndlc: 00000000: 80 02 03 01 59 c0
rcvQlen=1
nci: nci_rx_work: unknown MT 0x4
incoming frame:
ndlc: 00000000: 79 3e 59 c0 47 75 00 00 00 01 00 00 61 66 02 7e
ndlc: 00000010: 7e 7e 7e 7e 7e 7e 7e 7e 7e 7e 7e 7e 7e 7e 7e 40
ndlc: 00000020: 00 01 00 7e 7e 7e 7e 7e 7e 7e 7e 7e 7e 7e 7e 7e
ndlc: 00000030: 60 00 1f 02 01 20 02 1a 04 04 01 20 92 80 02 03
ndlc: 00000040: 01 59 c0 79 3e 59 c0 47 75 00 00 00 01 00 00 61
ndlc: 00000050: 66 02 7e 7e 7e 7e 7e 7e 7e 7e 7e 7e
rcvQlen=1
nci: nci_ntf_packet: unknown ntf opcode 0x93e
nci: __nci_request: wait_for_completion_interruptible_timeout failed 0

I've tried changing things like interrupt trigger (with rising edge 
only 1f 01 01 20 arrives, with falling edge nothing) but nothing seems 
to help. I wonder if anyone has any idea of what might be the actual 
cause of those strange frames. It's interesting that these two 
workaround patches were found necessary on one phone but not on another..

Thanks,
~val

