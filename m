Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D2A740D565;
	Wed, 22 Jul 2026 10:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784714960; cv=none; b=KRNxzvUVr4PlOBYZ6Sd9oCp+kiOVuaUG+MwLfM1F0T6Fw/U52ykHZnDToQdR+lJN2gBOc3z046nMbapVpDL58RaMWS/QhUrU/Mkw5EMG3ku/Nj9jiLslPl6GWrHl8QPhIoZGCeaXC9RgQ4Lmr+NVLbJKfoiwI7IIUGnYpeBs44c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784714960; c=relaxed/simple;
	bh=iSlsbaDWd9q/gkV1TiLHZvf8KO5b0kdEb2eoZw9N7wI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=clH6xtAnJl2Z9d7kY9DLQ7//91XBXGS5PEvMoXyl5lEu/jYG2Br3QGcm1qhYkBUqc65bnRSE1en+IwovMsUnFI/YF8oNUHn+Q7s3rirJrV68gKZmaM6YJt2/l9VMcGbf8zVHDooHzPZ3kRxgPcvNs5lWpHTIU71+fC+6jLo0ZSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=XGr8J6A1; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="XGr8J6A1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1784714957; x=1816250957;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=iSlsbaDWd9q/gkV1TiLHZvf8KO5b0kdEb2eoZw9N7wI=;
  b=XGr8J6A1EVNA2YCW63vs/3j7sdYc8mpDbr4VT7BnK3VqMeBOGdh2+c+J
   udXtWOvj6XS1WViC2MDREPWojcPJwakbHZIncz21K0vPEgerP/tSxFY+f
   lCvIsIY/KvwY8i721LY1r4gqkhfM5hJWsAh5CGCy5RLe0rFVUprlXMb9S
   MwH6rLfgHvqvbL8ZVozBL5QO1+4nrVvd6CabrENxaMoKUy05YtvNRzzNf
   E5+aJ4rsP94gAsmZEmqkBX7EKZOjCfYMfPpMj0aqLTIfPNsacJcAqK4VH
   TU65esUsmkAzKBU0sDzw9Bs4yB3o6ai0G8ntbKfNC0vyL78bPkfeQ1EwU
   g==;
X-CSE-ConnectionGUID: ctCHj+czQluVn7k3SWLUjg==
X-CSE-MsgGUID: qFWvq3/yTGuCO5/FCA33pA==
X-IronPort-AV: E=Sophos;i="6.25,178,1779174000"; 
   d="scan'208";a="228144423"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 Jul 2026 03:09:16 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Wed, 22 Jul 2026 03:09:16 -0700
Received: from [10.40.24.197] (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Wed, 22 Jul 2026 03:09:12 -0700
Message-ID: <419bb6ee-297c-4b88-8306-bc6a286c2e54@microchip.com>
Date: Wed, 22 Jul 2026 15:39:11 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v4 2/3] net: ethernet: oa_tc6: Improvements to error
 recovery
To: <Selvamani.Rajagopal@onsemi.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Andrew Lunn
	<andrew@lunn.ch>, Andrew Lunn <andrew+netdev@lunn.ch>, Piergiorgio Beruto
	<pier.beruto@onsemi.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
References: <20260720-fix-race-condition-and-crash-v4-0-8273e2f38a1f@onsemi.com>
 <20260720-fix-race-condition-and-crash-v4-2-8273e2f38a1f@onsemi.com>
Content-Language: en-US
From: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
In-Reply-To: <20260720-fix-race-condition-and-crash-v4-2-8273e2f38a1f@onsemi.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit

Imperative mood for the subject: "Improve error recovery" (netdev 
convention).

On 21/07/26 7:50 am, Selvamani Rajagopal via B4 Relay wrote:
>   static int oa_tc6_prcs_rx_chunk_payload(struct oa_tc6 *tc6, u8 *data,
> @@ -931,8 +966,7 @@ static int oa_tc6_prcs_rx_chunk_payload(struct oa_tc6 *tc6, u8 *data,
>          /* Process the chunk with only rx frame end */
>          if (end_valid && !start_valid) {
>                  size = end_byte_offset + 1;
> -               oa_tc6_prcs_rx_frame_end(tc6, data, size);
> -               return 0;
> +               return oa_tc6_prcs_rx_frame_end(tc6, data, size);
>          }
> 
>          /* Process the chunk with previous rx frame end and next rx frame
> @@ -946,6 +980,14 @@ static int oa_tc6_prcs_rx_chunk_payload(struct oa_tc6 *tc6, u8 *data,
>                  if (tc6->rx_skb) {
>                          size = end_byte_offset + 1;
>                          oa_tc6_prcs_rx_frame_end(tc6, data, size);
oa_tc6_prcs_rx_frame_end() now returns int, but this drops the return — 
every other call in this patch propagates it. Is it deliberate?
> +
> +                       /* Purpose of rx_buf_overflow is make the
> +                        * code to look for new frame. At this
> +                        * stage, we have a new frame to process.
> +                        * So, making it false, in case it is set
> +                        * to true by oa_tc6_prcs_rx_frame_end.
> +                        */
> +                       tc6->rx_buf_overflow = false;
>                  }
>                  size = OA_TC6_CHUNK_PAYLOAD_SIZE - start_byte_offset;
>                  return oa_tc6_prcs_rx_frame_start(tc6,
> @@ -954,9 +996,7 @@ static int oa_tc6_prcs_rx_chunk_payload(struct oa_tc6 *tc6, u8 *data,
>          }
> 
>          /* Process the chunk with ongoing rx frame data */
> -       oa_tc6_prcs_ongoing_rx_frame(tc6, data, footer);
> -
> -       return 0;
> +       return oa_tc6_prcs_ongoing_rx_frame(tc6, data, footer);
footer is unused here. Either drop the unused parameter or a note why it
stays.

Best regards,
Parthiban V
>   }
> 
